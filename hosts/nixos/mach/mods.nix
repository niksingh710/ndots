{ config, inputs, pkgs, lib, self, ... }:
let
  minimal-tmux = inputs.minimal-tmux.packages.${pkgs.system}.default;
  inherit (config.lib.stylix) colors;
in
{
  nixpkgs.overlays = [ inputs.nixgl.overlay ];
  environment.systemPackages = with pkgs.nixgl; [ nixGLIntel nixVulkanIntel ];

  hm = {
    home.file."stylix-mailspring" = {
      source = pkgs.callPackage "${self}/pkgs/stylix-mailspring" { inherit inputs colors; };
      target = ".config/Mailspring/packages/stylix-issac";
      recursive = true; # Copy the directory recursively
    };

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
    sops.secrets."private-keys/github_token" = { };
    programs.gh.package = lib.mkForce (pkgs.symlinkJoin {
      name = "gh";
      paths = [ pkgs.gh ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/gh \
          --run 'export GITHUB_TOKEN=''${GITHUB_TOKEN:-$(cat ${config.hm.sops.secrets."private-keys/github_token".path})}'
      '';
      meta.mainProgram = "gh";
    });
  };
}
