{ pkgs, ... }: {
  home.packages = [ pkgs.power-profiles-daemon ];
  programs.waybar.settings.mainBar = {
    modules-right = [ "group/power" ];

    "group/power" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      modules = [ "battery" "power-profiles-daemon" ];
    };
    battery = {
      rotate = 270;
      states = {
        good = 95;
        warning = 30;
        critical = 15;
      };
      format = "{icon}";
      format-charging = "<b>{icon} </b>";
      format-full = "<span color='#82A55F'><b>{icon}</b></span>";
      format-icons = [
        "󰁻"
        "󰁻"
        "󰁼"
        "󰁼"
        "󰁾"
        "󰁾"
        "󰂀"
        "󰂀"
        "󰂂"
        "󰂂"
        "󰁹"
      ];
      tooltip-format = "{timeTo} {capacity} % | {power} W";
    };
    power-profiles-daemon = {
      format = "{icon}";
      tooltip-format = ''
        Power profile= {profile}
        Driver= {driver}'';
      tooltip = true;
      format-icons = {
        default = "";
        performance = "<span color='#B37F34'><small></small></span>";
        balanced = "<span><small> </small></span>";
        power-saver = "<span color='#a6e3a1'><small></small></span>";
      };
    };
  };
}
