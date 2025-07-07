{
  # This file is not imported by the flake,
  # to get packages exported to the flake import the file in `flake.nix`
  perSystem = { pkgs, ... }: {
    packages.nixpkgs = pkgs.nixpkgs;
  };
}
