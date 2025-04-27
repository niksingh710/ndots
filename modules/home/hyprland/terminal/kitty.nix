{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  kitty-tmux = pkgs.writeScript "kitty-tmux" ''
    #!/bin/bash
    export TMUX_TMPDIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
    kitty -e tmux new-session -A -s main
  '';
in
{
  home.sessionVariables = {
    FZF_PREVIEW_IMAGE_HANDLER = if config.ndots.hyprland.terminal.kitty then "kitty" else "sixel";
    TERMINAL = if config.ndots.hyprland.terminal.kitty then "kitty" else "foot";
  };
  programs.kitty = {
    enable = config.ndots.hyprland.terminal.kitty;
    font.size = mkForce 10;
    # For: https://github.com/niksingh710/fzf-preview.git
    environment.FZF_PREVIEW_IMAGE_HANDLER = "kitty";
    settings = {
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = lib.optionals config.programs.kitty.enable [
      "$mod,Return,exec,kitty"
      "$modSHIFT,RETURN,exec,${kitty-tmux}"
    ];
  };
}
