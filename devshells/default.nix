{
  perSystem = { pkgs, ... }: {
    devShells = {
      default = import ./shell.nix { inherit pkgs; };
    };
  };
}
