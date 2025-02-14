{
  perSystem = { pkgs, ... }: {
    devShells = {
      default = pkgs.mkShell {
        packages = with pkgs;[ nil nixpkgs-fmt nh ];
      };
      dsa = import ./dsa.nix { inherit pkgs; };
    };
  };
}
