{ inputs, self, ... }: {

  # TODO: take out scripts from the rofi and all

  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
      inherit (self) opts;
      # specialArgs = { inherit inputs self opts; };
      args = hostName: {
        inherit inputs self;
        opts = opts // { inherit hostName; };
      };
    in
    {
      mach = nixosSystem {
        specialArgs = args "mach";
        modules = [
          ./mach
          # { disabledModules = [ ../nixos/optional/hardware/graphics.nix ]; }
        ];
      };
    };
}
