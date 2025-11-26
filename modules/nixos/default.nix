{ flake, ... }:
{
  imports = [
    flake.flakeModules.nix
    flake.nixosModules.stylix
  ];

  home-manager.sharedModules = [
    flake.homeModules.default
  ];
}
