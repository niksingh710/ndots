{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (pkgs) system;
in
{
  home.sessionVariables.EDITOR = "nvim";
  home.packages = [
    (inputs.nvix.packages.${system}.core.extend {
      nvix.explorer.neo-tree = false;
      nvix.explorer.oil = true;
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          background.dark = "mocha";
          dim_inactive.enabled = true;
          transparent_background = true;
        };
      };
    })
  ];
}
