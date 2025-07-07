{ flake, ... }:
let
  inherit (flake) self inputs;
in
{
  imports = [
    self.nixosModules.common
    self.darwinModules.settings
    self.darwinModules.packages
    inputs.mac-app-util.darwinModules.default


    self.darwinModules.stylix
    (self + /modules/home/stylix/config.nix)
  ];

  home-manager.sharedModules = [
    self.homeModules.default
    self.homeModules.packages
    self.homeModules.terminal
  ];
}
