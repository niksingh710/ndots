{ flake, ... }:
let
  inherit (flake) self;
in
{
  # This has to be same for darwin/home-manager/nixOs.
  home.stateVersion = "25.05";
  imports = [
    self.homeModules.shell
    self.homeModules.terminal
    self.homeModules.editor
    self.homeModules.ssh
    self.homeModules.nix-index
  ];
}
