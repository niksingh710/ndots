{ lib, config, ... }:
with lib;
let cfg = config.hmod.virtualisation;
in {
  options.hmod.virtualisation.qemu = mkEnableOption "qemu" // {
    default = true;
  };

  config = mkIf cfg.qemu {
    dconf.settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
