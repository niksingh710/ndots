{ lib, pkgs, ... }: {
  programs.waybar.settings.mainBar = {
    modules-right = [ "group/brightness" ];
    "group/brightness" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = false;
      };
      modules = [ "backlight" "backlight/slider" ];
    };
    backlight = {
      device = "intel_backlight";
      format = "{icon}";
      format-icons =
        [ "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ];
      on-scroll-down = "${lib.getExe pkgs.brightnessctl} s 5%-";
      on-scroll-up = "${lib.getExe pkgs.brightnessctl} s +5%";
      tooltip = true;
      tooltip-format = "Brightness= {percent}% ";
      smooth-scrolling-threshold = 1;
    };
    "backlight/slider" = {
      min = 5;
      max = 100;
      orientation = "vertical";
      device = "intel_backlight";
    };
  };
}
