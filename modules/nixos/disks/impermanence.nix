{ inputs, lib, config, opts, ... }:
with lib;
let
  cfg = config.nmod.disks;
  mount =
    if cfg.encrypted.enable then
      "/dev/mapper/cryptroot"
    else
      "/dev/disk/by-partlabel/disk-primary-root";

  cleanup = # bash
    ''
      mkdir /btrfs_tmp
      mount ${mount} /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp

    '';

in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options.persist = {
    dir = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    files = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
  config = mkIf cfg.impermanence {
    security.sudo.extraConfig = "Defaults lecture=never";
    fileSystems."/persistent".neededForBoot = true;

    boot.initrd = {
      postDeviceCommands =
        mkAfter (optionalString (!cfg.encrypted.enable) cleanup);
      systemd = mkIf cfg.encrypted.enable {
        enable = true;
        services.wipe-my-fs = {
          wantedBy = [ "initrd.target" ];
          after = [ "systemd-cryptsetup@cryptroot.service" ];
          before = [ "sysroot.mount" ];
          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = cleanup;
        };
      };
    };
    environment.persistence."/persistent" = {
      enable = true; # NB: Defaults to true, not needed
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/etc/secureboot"
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ] ++ config.persist.dir;
      inherit (config.persist) files;
      users.${opts.username} = {
        directories = [
          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = ".nixops";
            mode = "0700";
          }
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
        ] ++ config.hm.persist.dir;

        inherit (config.hm.persist) files;
      };
    };
  };
}
