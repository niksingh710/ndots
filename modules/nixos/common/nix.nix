{ flake, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  environment.systemPackages = with pkgs; [
    nixpkgs-track
    nixpkgs-manual
    nixpkgs-review

    nh
  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = lib.attrValues self.overlays;
  };

  nix = {
    # Choose from https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=nix
    # package = pkgs.nixVersions.latest;

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    nixPath = [ "nixpkgs=${flake.inputs.nixpkgs}" "nixpkgs-stable=${flake.inputs.nixpkgs-stable}" ]; # Enables use of `nix-shell -p ...` etc
    registry = {
      nixpkgs.flake = flake.inputs.nixpkgs; # Make `nix shell` etc use pinned nixpkgs
      nixpkgs-stable.flake = flake.inputs.nixpkgs-stable;
    };

    settings = {
      warn-dirty = false;
      max-jobs = "auto";
      experimental-features = "nix-command flakes";
      extra-platforms = lib.mkIf pkgs.stdenv.isDarwin "aarch64-darwin x86_64-darwin";
      # Nullify the registry for purity.
      flake-registry = builtins.toFile "empty-flake-registry.json" ''{"flakes":[],"version":2}'';
      trusted-users = [ (lib.optionalString pkgs.stdenv.isLinux "@wheel") ];
    };
  };
}
