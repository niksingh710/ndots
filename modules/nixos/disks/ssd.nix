{ lib, config, ... }:
with lib;
let cfg = config.nmod.disks.ssd;
in {
  options.nmod.disks.ssd = {
    enable = mkEnableOption "Enable SSD optimizations";
    options = mkOption {
      type = types.listOf types.str;
      default = [ "ssd" "discard=async" "noatime" "compress=zstd" ];
      description = ''
        List of mount options to use for SSDs.  The default is to enable
        the "discard" option, which allows the SSD to perform garbage
        collection.'';
    };
  };

  config = mkIf cfg.enable {
    services.fstrim.enable = cfg.enable;
    boot.initrd.availableKernelModules = [ "nvme" ];
  };
}
