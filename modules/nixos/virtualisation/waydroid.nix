{ lib, config, ... }:
with lib;
let cfg = config.nmod.virtualisation;
in {
  options.nmod.virtualisation.waydroid = mkEnableOption "waydroid";
  config.virtualisation.waydroid.enable = cfg.waydroid;
}
