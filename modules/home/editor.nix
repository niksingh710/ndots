{
  flake,
  pkgs,
  lib,
  config,
  ...
}:
{
  options.nvix.variant = lib.mkOption {
    type = lib.types.enum [
      "bare"
      "core"
      "full"
    ];
    default = "core";
    description = "Choose the variant of nvix to install.";
  };
  config = {
    home.sessionVariables.EDITOR = "nvim";
    home.packages = [

      (flake.inputs.nvix.packages.${pkgs.system}.${config.nvix.variant}.extend {
        config = {
          vimAlias = true;
          colorschemes = {
            catppuccin = {
              enable = true;
              settings = {
                background.dark = "mocha";
                transparent_background = true;
                color_overrides.all = {
                  base = "#000000";
                  mantle = "#000000";
                  crust = "#000000";
                };
              };
            };
          };
        };
      })
    ];

    programs.helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
      };
    };
  };
}
