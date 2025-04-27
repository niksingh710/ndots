{ inputs, self, ... }:
let
  # default opts structure
  dopts = {
    username = "";
    userEmail = "";
    round = false;
    hostName = "";
  };
  nixosGenerator =
    machine: system: opts:
    let
      path = # This will resolve to machine.nix if file is there else machine
        # Will help to include a dir with multiple files
        if builtins.pathExists ./${machine + ".nix"} then ./${machine + ".nix"} else ./${machine};
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs self;
        opts = dopts // opts // { hostName = machine; };
      };
      modules = [
        ./common.nix # nixos Common settings
        ./overlays.nix

        # setting the machine system type
        {
          nixpkgs.hostPlatform = system;
        }

        # machine specific settings tweaks
        # If the machine specific settings are grwoing much then create a dir
        # default.nix inside the dir will be imported here
        path
      ];
    };
in
{
  flake.nixosConfigurations = {
    vm = nixosGenerator "vm" "x86_64-linux" {
      username = "vm";
      userEmail = "vm@localhost";
    };
    mach = nixosGenerator "mach" "x86_64-linux" {
      username = "niksingh710";
      userEmail = "nik.singh710@gmail.com";
      rounding = false;
    };
  };
}
