{ inputs, pkgs, config, lib, ... }:
let minimal-tmux = inputs.minimal-tmux.packages.${pkgs.system}.default;
in lib.mkMerge [
  {
    persist.dir = [ ".local/share/zoxide" ];
    stylix.targets.fzf.enable = false;
    stylix.targets.tmux.enable = false;
    programs.tmux.plugins = [{
      plugin = minimal-tmux;
      extraConfig = ''
        set -g @minimal-tmux-bg "#${config.lib.stylix.colors.base01}"
        set -g @minimal-tmux-use-arrow true
        set -g @minimal-tmux-right-arrow ""
        set -g @minimal-tmux-left-arrow ""
      '';
    }];
  }

  (lib.mkIf config.hmod.sops.enable {

    sops.secrets."private-keys/github_token" = { };

    programs.gh.package = pkgs.symlinkJoin {
      name = "gh";
      paths = [ pkgs.gh ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/gh \
          --run 'export GITHUB_TOKEN=$(cat ${
            config.sops.secrets."private-keys/github_token".path
          })'
      '';
      meta.mainProgram = "gh";
    };
  })

]
