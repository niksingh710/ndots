# Module specifically for standalone home-manager configurations
{ flake, ... }:
{
  imports = [
    flake.homeModules.default
    flake.flakeModules.nix
  ];
}
