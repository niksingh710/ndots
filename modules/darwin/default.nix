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
  ];

  home-manager.sharedModules = [
    self.homeModules.default
  ];
}
