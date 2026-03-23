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

      (flake.inputs.nvix.packages.${pkgs.stdenv.hostPlatform.system}.${config.nvix.variant}.extend {
        config = {
          vimAlias = true;
          colorschemes.kanagawa = {
            enable = true;
            settings = {
              colors.theme.all.ui.bg_gutter = "none";
              undercurl = true;
              transparent = true;
              theme = "dragon";
              background = {
                dark = "dragon";
                light = "lotus";
              };
              commentStyle.italic = true;
              keywordStyle.italic = true;
              statementStyle.bold = true;
              overrides = # lua
                ''
                  function(colors)
                      local theme = colors.theme
                      local makeDiagnosticColor = function(color)
                      local c = require("kanagawa.lib.color")
                        return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
                      end
                      return {
                          NormalFloat = { bg = "none" },
                          FloatBorder = { bg = "none" },
                          FloatTitle = { bg = "none" },
                          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                          Pmenu = { fg = theme.ui.shade0, bg = "none", blend = vim.o.pumblend },
                          PmenuSel = { fg = "NONE", bg = "none" },
                          PmenuSbar = { bg = "none" },
                          BlinkCmpMenuBorder = { bg = "none" },
                          DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
                          DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
                          DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
                          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
                          TabLineFill = { bg = "none" },
                          TabLine = { bg = "none" },
                          TabLineSel = { bg = "none" },
                          TreesitterContext = { bg ="none",  ctermbg="none" },
                      }
                  end
                '';
            };
          };

          colorschemes.catppuccin = {
            enable = lib.mkForce false;
            settings.color_overrides.all = {
              base = "#000000";
              mantle = "#000000";
              crust = "#000000";
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
