{ config, opts, lib, ... }: with lib;
let
  inherit (config.lib.stylix) colors;
in
{
  services.mako = {
    enable = true;
    anchor = "bottom-right";
    borderRadius = if opts.rounding then 8 else 0;
    # backgroundColor = "#${colors.base00}";
    borderColor = mkForce "#${colors.base06}";
    # progressColor = "#${colors.base03}";
    # textColor = "#${colors.base03}";
    defaultTimeout = 6000;
    margin = "8";
    padding = "4";

    extraConfig = # ini
      ''
        outer-margin=0,0,8,0
        [urgency=low]
        border-color=#${colors.base08}
        [mode=dnd]
        invisible=1
        on-notify=none
      '';
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$modSHIFT,d,exec,makoctl mode -t dnd;pkill -RTMIN+2 waybar"
  ];
}
