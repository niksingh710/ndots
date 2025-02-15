{ lib, config, ... }:
{
  programs.foot = {
    enable = config.ndots.hyprland.terminal.foot;
    settings = {
      main = {
        pad = "5x0 center";
        font = lib.mkForce
          "${config.stylix.fonts.monospace.name}:size=12:termicons:size=10";
        term = "xterm-256color";
        dpi-aware = "no";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = lib.optionals config.programs.foot.enable [
      "$mod,Return,exec,foot"
      ''$modSHIFT,RETURN,exec,foot sh -c "TMUX_TMPDIR=''${XDG_RUNTIME_DIR:-/run/user/$(id -u)} tmux new-session -A -s main"''
    ];
  };
}
