{ inputs, self, ... }: {

  # TODO: take out scripts from the rofi and all

  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    inherit (self) opts;
    # specialArgs = { inherit inputs self opts; };
    args = oOpts: {
      inherit inputs self;
      opts = opts // oOpts;
    };
  in {
    mach = nixosSystem {
      specialArgs = args { hostName = "mach"; };
      modules = [
        ./mach
        # { disabledModules = [ ../nixos/optional/hardware/graphics.nix ]; }
      ];
    };

    vm = nixosSystem {
      specialArgs = args {
        hostName = "vm";
        username = "virt";
        mail = "virt@niksingh710.com";
      };
      modules = [
        ./vm
        # { disabledModules = [ ../nixos/optional/hardware/graphics.nix ]; }
      ];
    };

    iso = nixosSystem {
      specialArgs = args {
        platform = "x86_64-linux";
      };
      modules = [
        ./iso
      ];
    };

  };
}
