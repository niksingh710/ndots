{ flake, pkgs, lib, ... }:
{
  imports = [ flake.inputs.nix-index-database.homeModules.nix-index ];
  home.sessionVariables.COMMA_PICKER = lib.getExe pkgs.fzf;
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;
}
