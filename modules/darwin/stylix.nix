{ flake, ... }:
let
  inherit (flake.inputs) stylix;
in
{
  # Stylix comes for nix-darwin and NixOs and home-manager.
  imports = [
    stylix.darwinModules.stylix
  ];
}
