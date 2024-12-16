{ pkgs, config, lib, inputs, ... }:
with lib;
let
  cfg = config.nvix;

  nvix = inputs.nvix.packages.${pkgs.system}.full.extend {
    config = {
      calendar = true;
      colorschemes =
        {
          tokyonight.enable = mkForce false;
          nord.enable = true;
          base16 = {
            enable = false; # for any color scheme that is not base16

            colorscheme = {
              inherit (config.lib.stylix.colors.withHashtag)
                base00 base01 base02 base03 base04 base05 base06 base07
                base08 base09 base0A base0B base0C base0D base0E base0F;
            };
          };
        };
      highlight =
        let
          transparent = {
            bg = "none";
            ctermbg = "none";
          };
        in
        {
          Normal = transparent;
          NonText = transparent;
          SignColumn = transparent;
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
