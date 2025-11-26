{ flake, ... }:
{
  imports = [
    flake.flakeModules.nix

    flake.darwinModules.settings
    flake.darwinModules.brew
    flake.darwinModules.stylix
    flake.darwinModules.sharedModules
  ];
}
