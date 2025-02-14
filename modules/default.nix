{
  flake = {
    homeModules = import ./home; # My Custom modules for home-manager
    nixosModules = import ./nixos; # My Custom modules for home-manager
  };
}
