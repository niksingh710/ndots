{ self, inputs, ... }:
let
  hmGenerator =
    machine: system: opts:
    let
      path = # This will resolve to machine.nix if file is there else machine
        # Will help to include a dir with multiple files
        if builtins.pathExists ./${machine + ".nix"} then ./${machine + ".nix"} else ./${machine};
    in
    inputs.home-manager.lib.homeManagerConfiguration rec {
      # pkgs is from the flake's inputs.nixpkgs
      pkgs = import inputs.nixpkgs {
        config.allowUnfree = true;
        inherit system;
      };

      # extraSpecialArgs is alter to `_module.args` for homeManagerConfiguration
      # Check the home-manager module github for more args accepted by homeManagerConfiguration
      extraSpecialArgs = {
        # self is the flake-parts way to refer this flake
        inherit
          self
          inputs
          pkgs
          opts
          ;
      };
      modules = [
        ./common.nix # home-manager common settings

        # machine specific settings tweaks
        # If the machine specific settings are grwoing much then create a dir
        # default.nix inside the dir will be imported here
        path
      ];
    };

in
{
  flake.homeConfigurations = {

    # General standalone config for non-NixOS systems
    # Mostly focused on cli part -- can be used on (ubuntu, mint, arch, etc)
    virt = hmGenerator "virt" "x86_64-linux" {
      username = "virt";
      userEmail = "virt@localhost";
    };

    # For more home-manager only config just use hmGenerator directly
  };
}
