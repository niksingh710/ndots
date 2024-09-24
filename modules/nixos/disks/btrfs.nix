{ lib, config, ... }:
with lib;
let
  cfg = config.nmod.disks.btrfs;
  ssdOptions =
    optionals config.nmod.disks.ssd.enable config.nmod.disks.ssd.options;
in
{
  options.nmod.disks.btrfs = {
    enable = mkEnableOption "btrfs";
    description = ''
      Enable Btrfs filesystem support.
      Label: nixos
              subvol: root      -> /
                      home      -> /home
                      nix       -> /nix
                      btr_pool  -> /btr_pool

      Label: boot
              vfat -> /boot
    '';

    encrypted = {

      enable = mkEnableOption "btrfs-encrypted";

      uuid = mkOption {
        type = types.str;
        example = literalExample "/dev/disk/by-uuid/xxxx-xxxx-xxxx-xxxx";
        # default = "/dev/disk/by-uuid/xxxx-xxxx-xxxx-xxxx";
        description = ''
          This is the UUID of the encrypted partition.
        '';
      };

      name = mkOption {
        type = types.str;
        example = literalExample "cryptroot";
        default = "cryptroot";
        description = ''
          Name of the encrypted partition.
        '';
      };

    };

    backup = {
      enable = mkEnableOption "btrfs-backup";
      target = mkOption {
        type = types.str;
        example = literalExample "/run/media/<username>/hdd";
        default = "/btr_pool/btr_backup";
        description = ''
          Target Dir where the backup will be stored.
                  External drive is recommended.
        '';
      };
    };

  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "btrfs" "vfat" ];

    boot.initrd = optionalAttrs cfg.encrypted.enable {
      luks.devices."${cfg.encrypted.name}".device = cfg.encrypted.uuid;
    };

    fileSystems = {
      "/" = mkDefault {
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        options = [ "subvol=root" ] ++ ssdOptions;
      };
      "/home" = mkDefault {
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        options = [ "subvol=home" ] ++ ssdOptions;
      };

      "/nix" = mkDefault {
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        options = [ "subvol=nix" ] ++ ssdOptions;
      };

      "/boot" = mkDefault {
        device = "/dev/disk/by-label/boot";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
      "/btr_pool" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "btrfs";
        options = [ "subvolid=5" ] ++ ssdOptions;
      };
    };

    services.btrfs = {
      autoScrub = {
        interval = "weekly";
        enable = true;
      };
    };

    services.btrbk = optionalAttrs cfg.backup.enable {
      instances.btrbk.settings = {
        snapshot_preserve = "9d";
        snapshot_preserve_min = "2d";
        target_preserve = "9d 4w 2m";
        target_preserve_min = "no";

        volume = {
          "/btr_pool" = {
            subvolume = {
              "root".snapshot_create = "onchange";
              "home".snapshot_create = "onchange";
            };

            # backup to a remote server or a local directory
            inherit (cfg.backup) target;
            snapshot_dir = "/btr_pool/snapshots";
          };
        };

      };
    };

  };
}
