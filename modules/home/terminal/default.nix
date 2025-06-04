{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      size = 14;
    };
    environment.FZF_PREVIEW_IMAGE_HANDLER = "kitty";
    settings = {
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      macos_option_as_alt = "yes";
    };
  };
}
