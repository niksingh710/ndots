{ flake, pkgs, ... }:
let
  inherit (flake.inputs) stylix;
in
{
  # Stylix comes for nix-darwin and NixOs and home-manager.
  # This one is only for home-manager.
  imports = [
    stylix.homeModules.stylix
  ];
}
