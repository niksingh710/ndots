{ flake, ... }:
{
  imports = [
    flake.nixosModules.common
    flake.nixosModules.stylix
  ];

  home-manager.sharedModules = [
    flake.homeModules.default
  ];
}
