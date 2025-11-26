{ flake, ... }:
{
  imports = [
    # the file import should have worked with
    # flake.nixosModules.common but recent nix changes throwing errors
    # TODO: Clean this up by shifting this to nixModules
    ../../modules/nixos/common/nix.nix
    ../../modules/nixos/common/caches.nix

    flake.darwinModules.settings
    flake.darwinModules.brew
    flake.darwinModules.stylix
    flake.darwinModules.sharedModules
  ];
}
