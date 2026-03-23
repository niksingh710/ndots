# Contains override for packages/moduels
# Most of my modules are meant to be used by multiple users
# and multiple people online.
# here in this config file i override them according to my needs
{
  flake,
  pkgs,
  config,
  ...
}:
let
  me = (import (flake + "/config.nix")).me // {
    username = "nikhil.singh";
  };
in
{
  # users specific home modules
  imports = [
    flake.homeModules.ai
    flake.homeModules.terminal
    flake.homeModules.syncthing
  ];

  services.syncthing = {
    # CPU is in office and ssh key get's there by ssh-agent forwarding, so skipping sops here
    # Passwordfile is to be expected in a manual path
    passwordFile = "${config.home.homeDirectory}/.syncthing.pass";
    settings = {
      gui.user = me.username;
    };
  };
  # comes from homeModules.editor
  nvix.variant = "core";

  # Color override for tmux plugin
  programs.tmux.plugins = [
    {
      plugin = pkgs.tmuxPlugins.minimal-tmux-status;
      extraConfig = ''
        set -g @minimal-tmux-use-arrow true
        set -g @minimal-tmux-bg "#555555"
        set -g @minimal-tmux-right-arrow " "
        set -g @minimal-tmux-left-arrow " "
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
    includes = [
      {
        condition = "gitdir:~/work/bitbucket/";
        contents.user.email = "${me.username}@juspay.in";
      }
    ];
  };
}
