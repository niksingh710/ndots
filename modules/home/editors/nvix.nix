{ pkgs, config, lib, inputs, ... }:
with lib;
let
  cfg = config.nvix;

  nvix = inputs.nvix.packages.${pkgs.system}.full.extend {
    config = {
      calendar = true;
      colorschemes =
        {
          gruvbox = {
            enable = true;
            settings = {
              transparent_mode = true;
              contrast = "hard";
            };
          };
          tokyonight = {
            enable = mkForce false;
            settings.transparent = true;
          };
        };
      extraConfigLua = # lua
        ''
          if vim.g.neovide then
            vim.g.neovide_transparency = ${builtins.toString config.stylix.opacity.terminal}
            vim.cmd([[highlight Normal guibg=#${config.lib.stylix.colors.base00}]])
          end
        '';
    };
  };

  fontName =
    if config.hmod.sops.enable then
      "MonoLisaScript Nerd Font"
    else
      "JetBrainsMono Nerd Font";
in
{
  options.nvix = {
    enable = mkEnableOption "Enabling nvix" // { default = true; };
    pkg = mkOption {
      type = types.package;
      default = nvix;
    };
  };

  # packages are coming from the overlay
  config = mkIf cfg.enable {
    persist.dir = [ ".local/share/nvim" ".local/state/nvim" ".config/github-copilot" ".cache/nvim" ".cache/calendar.vim" ];
    programs.neovide = {
      enable = false; # TODO: enable when the cctools bug is fixed https://github.com/NixOS/nixpkgs/pull/356292
      settings = {
        font = {
          normal = fontName;
          size = 12;
        };
      };
    };
    home = {
      sessionVariables.EDITOR = "vim";
      shellAliases.gvim = "setsid neovide $@ &>/dev/null";
      shellAliases.gcal = "nvim -c 'Calendar'";
      packages = [ cfg.pkg ];
    };
  };
}
