{ flake, pkgs, ... }:
let
  inherit (flake) self;
in
{
  # This has to be same for darwin/home-manager/nixOs.
  home.stateVersion = "25.05";
  fonts.fontconfig.enable = true;
  home.packages = with pkgs;[ monaspace ];
  imports = [
    self.homeModules.shell
    self.homeModules.editor
    self.homeModules.ssh
    self.homeModules.nix-index
  ];
}
