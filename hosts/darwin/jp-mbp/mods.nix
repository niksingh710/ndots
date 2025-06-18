{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  minimal-tmux = inputs.minimal-tmux.packages.${pkgs.system}.default;
in
{
  hm = {
    home.packages = with pkgs; [
      omnix
    ];
    programs.tmux.plugins = [
      {
        plugin = minimal-tmux;
        extraConfig = ''
          set -g @minimal-tmux-use-arrow true
          set -g @minimal-tmux-right-arrow ""
          set -g @minimal-tmux-left-arrow ""
        '';
      }
    ];
    sops.secrets."private-keys/github_token" = { };
    # TODO: make this gh override common for nixos/linux and darwin
    programs.gh.package = lib.mkForce (
      pkgs.symlinkJoin {
        name = "gh";
        paths = [ pkgs.gh ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/gh \
            --run 'export GITHUB_TOKEN=''${GITHUB_TOKEN:-$(cat ${
              config.hm.sops.secrets."private-keys/github_token".path
            })}'
        '';
        meta.mainProgram = "gh";
      }
    );
  };

}
