{ opts, inputs, ... }:
let
  inherit (opts) username;
in
{
  nixpkgs.config = {
    allowUnfree = true;
  };
  # Necessary for using flakes on this system.
  nix = {
    registry.nixpkgs.flake = inputs.nixpkgs;
    enable = true;
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        username
        "root"
        "@admin"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
      ];
    };
  };

}
