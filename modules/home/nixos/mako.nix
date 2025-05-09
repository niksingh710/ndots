{
  config,
  opts,
  lib,
  ...
}:
with lib;
let
  inherit (config.lib.stylix) colors;
in
{
  services.mako = {
    enable = true;

    settings = {
      anchor = "bottom-right";
      border-radius = if opts.rounding then 8 else 0;
      border-color = mkForce "#${colors.base06}";
      default-timeout = 6000;
      margin = "8";
      padding = "4";
      outer-margin = "0,0,8,0";
    };
    criteria = {
      "urgency=low" = {
        border-color = lib.mkForce "#${colors.base08}";
      };
      "mode=dnd" = {
        invisible = "true";
        on-notify = "none";
      };
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$modSHIFT,d,exec,makoctl mode -t dnd;pkill -RTMIN+2 waybar"
  ];
}
