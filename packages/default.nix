{
  # This file is not imported by the flake,
  # to get packages exported to the flake import the file in `flake.nix`
  # TODO: Move <https://github.com/niksingh710/utils> to packages
  perSystem = { pkgs, ... }: {
    packages.nixpkgs = pkgs.nixpkgs;
  };
}
