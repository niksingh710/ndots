{ lib, config, ... }:
with lib;
let
  cfg = config.ndots.disk;
in
{
  # This is a general partition layout that i like, based on btrfs
  # Available options are for encrypted device and non-encrypted device
  # Structure of the disk
  # nvme0n1       259:0    0 953.9G  0 disk
  # ├─nvme0n1p1   259:1    0   512M  0 part  /boot
  # └─nvme0n1p2   259:2    0 953.4G  0 part
  #   └─cryptroot 254:0    0 953.4G  0 crypt /<partition>
  # No need to specify filesystem disko will take care for that
  # If not using this module in nixos, then make sure to manually set filesystem

  options.ndots.disk = {
    encrypted = mkEnableOption "Host disk is encrypted!?";
    impermanence = mkEnableOption "Disk is impermanent?";
    btrfs = mkEnableOption "Use btrfs for root partition?" // {
      default = true;
    };
    ssd = {
      enable = mkEnableOption "Disk type is ssd?" // {
        default = true;
      };
      options = mkOption {
        type = types.listOf types.str;
        default = [
          "ssd"
          "discard=async"
          "noatime"
          "compress=zstd"
        ];
        description = "Options for ssd disk";
      };
    };
    device = mkOption {
      type = types.str;
      description = "Device to opt for partition";
    };
  };
  config = {
    boot.initrd.availableKernelModules = optionals cfg.ssd.enable [ "nvme" ];
    boot.supportedFilesystems = [
      "btrfs"
      "vfat"
    ];

    services.fstrim.enable = cfg.ssd.enable;
    services.btrfs = mkIf cfg.btrfs {
      autoScrub = {
        interval = "weekly";
        enable = true;
      };
    };
  };

  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}
