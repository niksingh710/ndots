{ lib, config, ... }:
with lib;
let cfg = config.nmod.virtualisation;
in {
  options.nmod.virtualisation.waydroid = mkEnableOption "waydroid";
  config = {
    hm.persist.dir = [
      ".local/share/waydroid"
    ];
    persist.dir = [
      "/var/lib/waydroid"
      "/etc/waydroid"
    ];
    virtualisation.waydroid.enable = cfg.waydroid;
  };
}
