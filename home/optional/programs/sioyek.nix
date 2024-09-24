{ config, ... }: {
  programs.sioyek = {
    enable = true;
    bindings = {
      "zoom_in" = "J";
      "zoom_out" = "K";
      "next_page" = "n";
      "prev_page" = "p";
      "goto_toc" = "t";
      "rotate_clockwise" = ">";
      "rotate_counteclockwise" = "<";
      "reload" = "r";
      "toggle_dark_mode" = "i";
      "toggle_presentation_mode" = "p";
      "move_up" = "k";
      "move_down" = "j";
      "move_left" = "h";
      "move_right" = "l";
      "screen_down" = [ "d" "<C-d>" ];
      "screen_up" = [ "u" "<C-u>" ];
    };
    config =
      let inherit (config.lib.stylix) colors;
      in {
        "default_dark_mode" = "true";
        "dark_mode_background_color" =
          "${colors.base00-dec-r} ${colors.base00-dec-g} ${colors.base00-dec-b}";
        "background_color" =
          "${colors.base0F-dec-r} ${colors.base0F-dec-g} ${colors.base0F-dec-b}";
      };
  };
}
