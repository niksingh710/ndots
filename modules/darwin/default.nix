{ flake, ... }:
{
  imports = [
    flake.nixosModules.common
    flake.darwinModules.settings
    flake.darwinModules.brew
    flake.darwinModules.stylix
    flake.darwinModules.sharedModules
  ];
}
