{ config, lib, ... }:
let inherit (config.lib.stylix) colors;
in {
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = {
      general = { disable_loading_bar = false; };

      background = [{
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
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

      input-field = [{
        monitor = "";
        size = "200, 30";
        outline_thickness = 2;
        outer_color = "0x44${colors.base0F}";
        inner_color = "0x00${colors.base0F}";

        font_color = "0xff${colors.base0F}";
        fade_on_empty = false;

        position = "0, -70";
        halign = "center";
        valign = "center";
      }];

      label = [
        {
          monitor = "";
          text = "$TIME"; # Text rendered in the label.
          color = "0xff${colors.base0F}";
          font_size = 130;
          font_family = "Road Rage";

          position = "0, 340";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "<b>  </b>"; # Text rendered in the label.
          color = "0xff${colors.base0F}";
          font_size = 80;
          font_family = "Noto Sans";

          position = "0, -400";
          halign = "center";
          valign = "center";
        }
      ];

    };
  };
}
