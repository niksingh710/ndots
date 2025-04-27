{ inputs, self, ... }:
let
  minimalIsoBuilder =
    machine: hostPlatform: opts:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        opts = opts // {
          hostName = machine;
        };
        inherit inputs self hostPlatform;
      };
      modules = [ ./minimal.nix ];
    };
in
{
  # `nix build .#<name>.config.system.build.isoImage`
  flake = rec {

    x86ISO = minimalIsoBuilder "nixos" "x86_64-linux" {
      username = "nixos";
      userEmail = "nixos@iso";
    };

    iso = x86ISO.config.system.build.isoImage;
  };
}
