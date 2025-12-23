# Contains override for packages/moduels
# Most of my modules are meant to be used by multiple users
# and multiple people online.
# here in this config file i override them according to my needs
{
  flake,
  pkgs,
  ...
}:
let
  me = (import (flake + "/config.nix")).me;
in
{
  # users specific home modules
  imports = [
    flake.homeModules.ai
  ];

  # comes from homeModules.editor
  nvix.variant = "core";

  # Color override for tmux plugin
  programs.tmux.plugins = [
    {
      plugin = pkgs.tmuxPlugins.minimal-tmux-status;
      extraConfig = ''
        set -g @minimal-tmux-use-arrow true
        set -g @minimal-tmux-right-arrow ""
        set -g @minimal-tmux-left-arrow ""
      '';
    }
  ];

  programs.git = {
    settings = {
      user = {
        name = me.fullname;
        email = me.email;
      };
    };
  };
}
