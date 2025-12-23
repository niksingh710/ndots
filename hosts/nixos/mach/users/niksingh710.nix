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
  me = (import (flake + "/config.nix")).me;
in
{
  # users specific home modules
  imports = [
    flake.homeModules.sops
    flake.homeModules.ai
  ];

  sops.secrets = {
    "private-keys/gemini_api" = { };
    "private-keys/openai_api" = { };
    "private-keys/github_token" = { };
    "private-keys/anthropic-jp-key" = { };
    "private-keys/jp-grid" = { };
    "private-keys/ssh" = {
      path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      mode = "0600";
    };

    "rclone/conf".path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
    "rclone/locked-conf".path = "${config.home.homeDirectory}/.config/rclone/rclone.conf.lock";
  };

  home.sessionVariables = {
    OPENAI_API_BASE = "https://api.githubcopilot.com";
    OPENAI_API_KEY = "$(cat ${config.sops.secrets."private-keys/openai_api".path})";
    GEMINI_API_KEY = "$(cat ${config.sops.secrets."private-keys/gemini_api".path})";
    GITHUB_TOKEN = "$(cat ${config.sops.secrets."private-keys/github_token".path})";
    ANTHROPIC_AUTH_TOKEN = "$(cat ${config.sops.secrets."private-keys/anthropic-jp-key".path})";
    ANTHROPIC_BASE_URL = "$(cat ${config.sops.secrets."private-keys/jp-grid".path})";
    SOPS_AGE_KEY_FILE = config.sops.age.keyFile;
  };

  # comes from homeModules.editor
  nvix.variant = "full";

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
