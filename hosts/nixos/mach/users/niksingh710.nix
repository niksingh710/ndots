# Contains override for packages/moduels
# Most of my modules are meant to be used by multiple users
# and multiple people online.
# here in this config file i override them according to my needs
{
  flake,
  pkgs,
  lib,
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
    flake.homeModules.sops
  ];

  sops.secrets = {
    "private-keys/gemini_api" = { };
    "private-keys/openai_api" = { };
    "private-keys/github_token" = { };
    "private-keys/ssh" = {
      path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      mode = "0600";
    };
  };
  home.sessionVariables = {
    OPENAI_API_BASE = "https://api.githubcopilot.com";
    OPENAI_API_KEY = "$(cat ${config.sops.secrets."private-keys/openai_api".path})";
    GEMINI_API_KEY = "$(cat ${config.sops.secrets."private-keys/gemini_api".path})";
    GITHUB_TOKEN = "$(cat ${config.sops.secrets."private-keys/github_token".path})";
    SOPS_AGE_KEY_FILE = config.sops.age.keyFile;
  };

  # comes from homeModules.editor
  nvix.variant = "full";

  # Color override for tmux plugin
  programs.tmux.plugins = [
    {
      plugin = pkgs.tmuxPlugins.minimal-tmux-status;
      extraConfig = ''
        set -g @minimal-tmux-bg "#${config.lib.stylix.colors.base01}"
        set -g @minimal-tmux-fg "#${config.lib.stylix.colors.base06}"
        set -g @minimal-tmux-use-arrow true
        set -g @minimal-tmux-right-arrow ""
        set -g @minimal-tmux-left-arrow ""
      '';
    }
  ];
  # git override for my personal/work email setup
  programs.git = {
    settings = {
      userName = me.fullname;
      userEmail = me.email;
    };
    includes = [
      {
        condition = "gitdir:~/work/bitbucket/";
        contents.user.email = "${me.username}@juspay.in";
      }
    ];
  };
  stylix.targets.fzf.enable = false;
  # Kitty terminal override
  programs.kitty = {
    font.size = lib.mkForce 16;
    settings.background_opacity = lib.mkForce 0;
  };

  # color override as it comes from stylix
  services.jankyborders.settings.active_color = "0xff${config.lib.stylix.colors.base06}";

  # Telegram theming via stylix, using walogram package
  home.activation.tg-theme = lib.hm.dag.entryAfter [ "" ] ''
    run ${
      lib.getExe (
        pkgs.utils.walogram.override {
          image = "${config.stylix.image}";
          colors = (
            with config.lib.stylix.colors;
            ''
              color0="#${base00}"
              color1="#${base01}"
              color2="#${base02}"
              color3="#${base03}"
              color4="#${base04}"
              color5="#${base05}"
              color6="#${base06}"
              color7="#${base07}"
              color8="#${base08}"
              color9="#${base09}"
              color10="#${base0A}"
              color11="#${base0B}"
              color12="#${base0C}"
              color13="#${base0D}"
              color14="#${base0E}"
              color15="#${base0F}"
            ''
          );
        }
      )
    }
  '';
}
