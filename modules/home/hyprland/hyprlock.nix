{ config, lib, self, pkgs, ... }:
let inherit (config.lib.stylix) colors;
in {
  stylix.targets.hyprlock.enable = false;
  home.packages = [ self.packages.${pkgs.system}.road-rage ];
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
      };


      background = [{
        path = "screenshot";
        blur_passes = 2;
        contrast = 0.9;
        brightness = 0.5;
        vibrancy = 0.17;
        vibrancy_darkness = 0;
      }];

      image = [{
        monitor = "";
        # path = ~/.face.png
        size = 150;
        rounding = -1;
        border_size = 3;
        border_color = "0x44${colors.base0F}";
        rotate = 0;
        reload_time = -1;
        reload_cmd = "";

        position = "0, 70";
        halign = "center";
        valign = "center";
      }];

      input-field = [
        {
          size = "300, 40";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba (0, 0, 0, 0)";
          inner_color = "0x80${colors.base0F}";
          font_color = "0xffc8c8c8";
          fade_on_empty = false;
          font_family = "${config.stylix.fonts.monospace.name}";
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];

      label = [

        # Hour-Time
        {
          text = ''cmd[update:1000] echo -e "$(date +"%H")"'';
          color = "0x80${colors.base0F}";
          font_family = "Road Rage";
          font_size = "140";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }

        # Minute-Time
        {
          text = ''cmd[update:1000] echo -e "$(date +"%M")"'';
          color = "rgba(255, 255, 255, 1)";
          font_family = "Road Rage";
          font_size = "140";
          position = "0, 75";
          halign = "center";
          valign = "center";
        }

        # Day-Date-Month
        {
          text = ''cmd[update:1000] echo "<span color='##ffffff00'>$(date '+%A, ')</span><span color='##928cff00'>$(date '+%d %B')</span>"'';
          font_size = "30";
          font_family = "${config.stylix.fonts.monospace.name}";
          position = "0, 80";
          halign = "center";
          valign = "bottom";
        }

        # CURRENT SONG
        {
          text = ''cmd[update:1000] echo "$(${lib.getExe pkgs.playerctl} metadata --format '{{title}} | {{artist}}')"'';
          color = "rgba(255, 255, 255, 1)";
          font_size = 17;
          font_family = "${config.stylix.fonts.monospace.name}";
          position = "0, 200";
          halign = "center";
          valign = "bottom";
        }
      ];

    };
  };
}
