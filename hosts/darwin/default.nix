{ inputs, self, ... }:
let
  # default opts structure
  dopts = {
    username = "";
    userEmail = "";
    hostName = "";
  };
  darwinGenerator =
    machine: system: opts: dir:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs self;
        opts = dopts // opts // { hostName = machine; };
      };
      modules = [
        ./common.nix # Common settings

        # setting the machine system type
        {
          nixpkgs.hostPlatform = system;
          system.primaryUser = "${opts.username}";
        }

        inputs.mac-app-util.darwinModules.default

        # machine specific settings tweaks
        # If the machine specific settings are growing much then create a dir
        # default.nix inside the dir will be imported here
        dir
      ];
    };
in
{
  flake.darwinConfigurations = {
    mbp = darwinGenerator "Nikhil-Singh-CG74J76YJM" "aarch64-darwin" {
      username = "nikhil.singh";
      userEmail = "nikhil.singh@juspay.in";
    } ./jp-mbp;
  };
}
