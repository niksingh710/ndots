{
  flake = {
    nixosModules = import ./nixos;
    homeModules = import ./home;
  };
}
