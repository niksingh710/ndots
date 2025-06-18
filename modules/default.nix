{
  flake = {
    homeModules = import ./home; # My Custom modules for home-manager
    nixosModules = import ./nixos; # My Custom modules for nixos
    darwinModules = import ./darwin; # My Custom modules for darwin
  };
}
