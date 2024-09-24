{

  imports = [
    ./hyprland.nix
    ./stats.nix
    ./recorder.nix
    ./backlight.nix
    ./audio.nix
    ./notification.nix
    ./network.nix
    ./general.nix
    ./power.nix

    ./style.nix
  ];

  stylix.targets.waybar.enable = false;
  wayland.windowManager.hyprland.settings = {
    bind = [ "SUPER,b,exec,killall -SIGUSR1 .waybar-wrapped" ];
    exec = [ "systemctl --user restart waybar" ];
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "right";
        margin = "5 2 5 0";
        reload_style_on_change = true;
      };
    };
  };

}
