{ lib, ... }:
with lib;
{
  # TODO: Add custom/github module back
  stylix.targets.waybar.enable = false;

  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "ignorezero, waybar"
      "blur, waybar"
    ];
    bind = [ "SUPER,b,exec,killall -SIGUSR1 .waybar-wrapped" ];
  };

  systemd.user.services.waybar.Unit.After = lib.mkForce [ "graphical-session.target" ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "right";
        margin = "4 0";
        reload_style_on_change = true;
      };
    };
  };
  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}
