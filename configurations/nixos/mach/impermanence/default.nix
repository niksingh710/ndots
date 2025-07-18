# Impermanenet setup is purely designed for ndots
# make sure you understand the partition scheme and mount points.
{ flake, lib, config, ... }:
let
  inherit (flake) inputs;
  cfg = config.ndots.disko;
  mount =
    if cfg.encrypted.enable then "/dev/mapper/${cfg.encrypted.name}" else "/dev/disk/by-partlabel/disk-primary-root";
  cleanup = # bash
    ''
      # This script cleans the disk at boot to have clean setup
      # also keeps backup of the previous boot
      mkdir -p /btrfs_tmp
      mount ${mount} /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%b-%d-%Y_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      # Deleting backup older than 30 days
      find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30 -exec bash -c 'delete_subvolume_recursively "$0"' {} \;

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./persist.nix
  ];

  fileSystems."/persistent".neededForBoot = true;

  # If drive is encrypted the systemd service will wipe the disk
  # else postDeviceCommand will do the wiping
  # `cryptroot` is the encrypted drive luks name, can be changed in ndots.disko options
  boot.initrd = with lib; {
    postDeviceCommands = mkAfter (optionalString (!cfg.encrypted.enable) cleanup);
    systemd = {
      # This will allow systemd to run at initrd
      enable = cfg.encrypted.enable;
    } // optionalAttrs cfg.encrypted.enable {
      services.wipe-my-fs = {
        wantedBy = [ "initrd.target" ];
        after = [ "systemd-cryptsetup@${cfg.encrypted.name}.service" ];
        before = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = cleanup;
      };
    };
  };

}
