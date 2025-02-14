{ config, inputs, pkgs, ... }:
let
  minimal-tmux = inputs.minimal-tmux.packages.${pkgs.system}.default;
in
{
  hm = {

    stylix.targets.fzf.enable = false;
    stylix.targets.tmux.enable = false;
    stylix.targets.swaylock.enable = false;

    programs.tmux.plugins = [{
      plugin = minimal-tmux;
      extraConfig = ''
        set -g @minimal-tmux-bg "#${config.lib.stylix.colors.base01}"
        set -g @minimal-tmux-use-arrow true
        set -g @minimal-tmux-right-arrow ""
        set -g @minimal-tmux-left-arrow ""
      '';
    }];
  };
}
