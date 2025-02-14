{ inputs, pkgs, ... }:
{
  flake.overlays = {
    nixos = import ./nixos.nix { inherit inputs pkgs; };
  };
}
