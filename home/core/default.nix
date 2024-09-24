{ inputs, pkgs, config, ... }:
let minimal-tmux = inputs.minimal-tmux.packages.${pkgs.system}.default;
in {
  imports = with builtins;
    map (fn: ./${fn})
    (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  stylix.targets.fzf.enable = false;
  stylix.targets.tmux.enable = false;
  programs.tmux.plugins = [{
    plugin = minimal-tmux;
    extraConfig = ''
      set -g @minimal-tmux-bg "#${config.stylix.base16Scheme.base01}"
    '';
  }];
}
