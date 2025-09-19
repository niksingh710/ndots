{ flake, ... }:
{
  # Stylix comes for nix-darwin and NixOs and home-manager.
  imports = [
    flake.inputs.stylix.darwinModules.stylix

    (flake.homeModules.stylix + "/config.nix")
  ];
}
