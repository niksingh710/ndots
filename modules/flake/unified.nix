{ inputs, self, ... }:
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];
  debug = true;
  perSystem = { lib, system, self', ... }: {

    # Make our overlay available to the devShell
    # "Flake parts does not yet come with an endorsed module that initializes the pkgs argument.""
    # So we must do this manually; https://flake.parts/overlays#consuming-an-overlay
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = lib.attrValues self.overlays;
      config.allowUnfree = true;
    };

    packages.default = self'.packages.activate;

    # Flake inputs we want to update periodically
    # Run: `nix run .#update`.
    nixos-unified = {
      primary-inputs = [
        "nixpkgs"
        "home-manager"
        "nix-darwin"
        "nixos-unified"
        "nix-index-database"
        "nvix"
        "omnix"
      ];
    };
  };
}
