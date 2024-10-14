{
  perSystem = { pkgs, ... }: {
    packages = {
      road-rage = pkgs.callPackage ./road-rage { };
    };

    # For 'nix fmt'
    formatter = pkgs.nixpkgs-fmt;
  };
}
