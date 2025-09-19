{ flake, ... }:
{
  imports = [
    flake.nixosModules.common
    flake.darwinModules.settings
    flake.darwinModules.brew
    flake.darwinModules.stylix
    flake.darwinModules.sharedModules

    # linking apps to spotlight
    flake.inputs.mac-app-util.darwinModules.default
  ];
}
