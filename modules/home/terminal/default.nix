{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 16;
    };
    environment.FZF_PREVIEW_IMAGE_HANDLER = "kitty";
    keybindings = {
      "cmd+enter" = "toggle_fullscreen";
    };
    settings = {
      background_opacity = "0.8";
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      macos_option_as_alt = "yes";
      # hide_window_decorations = "yes";
      macos_traditional_fullscreen = "yes";
      dynamic_background_opacity = "yes";
      background_blur = 200;
    };
  };
}
