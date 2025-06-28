{ pkgs, ... }:
{
  home.sessionVariables.EDITOR = "nvim";
  home.packages = [ pkgs.nvix ];
}
