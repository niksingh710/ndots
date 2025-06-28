{ lib, ... }:
with lib;{
  programs = {
    kitty = {
      enable = mkDefault true;
      environment.FZF_PREVIEW_IMAGE_HANDLER = "kitty";
      font = {
        name = mkDefault "JetBrainsMono Nerd Font Mono";
      };
      keybindings = {
        "cmd+opt+s" = "no_op";
      };
      settings =
        {
          background_blur = 64;
          window_padding_width = 4;
          hide_window_decorations = "titlebar-only";
          confirm_os_window_close = 0;
          enable_audio_bell = false;
          macos_option_as_alt = "yes";
          dynamic_background_opacity = "yes";

          # tabs
          # I rely on tmux, but still for those who want tabs
          tab_bar_style = "custom";
          tab_bar_edge = "top";
          tab_bar_align = "left";
          tab_powerline_style = "slanted";
          active_tab_font_style = "italic";
          tab_title_template = "[{index}] {title}";
          active_tab_title_template = "[{index}] {title}";
          cursor_trail = 3;

          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";
        };
    };
  };
}
