{
  flake = {
    homeModules = import ./home; # My Custom modules for home-manager
    nixosModules = import ./nixos; # My Custom modules for nixos
    darwinModules = import ./darwin; # My Custom modules for darwin
  };

  # Utility function to read all directories in a given path
  readAllDirs = path: builtins.filter (p: builtins.pathExists (path + "/" + p) && builtins.isDirectory (path + "/" + p)) (builtins.readDir path);
}
