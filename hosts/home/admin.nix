{ flake, ... }:
{
  imports = [
    flake.homeModules.default
    flake.homeModules.home-only
  ];
}
