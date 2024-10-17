{ lib, config, ... }:
with lib;
let cfg = config.hmod.virtualisation;
in {
  options.hmod.virtualisation.waydroid = mkEnableOption "waydroid";

  config.home.shellAliases = lib.mkIf cfg.waydroid {
    waydroid-start =
      "sudo systemctl start waydroid-container;setsid waydroid show-full-ui &>/dev/null";
    waydroid-status = "sudo systemctl status waydroid-container";
    waydroid-stop =
      "sudo waydroid container stop;sleep 1;sudo systemctl stop waydroid-container";
  };

}
