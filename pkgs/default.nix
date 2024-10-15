{
  perSystem = { pkgs, ... }: {
    packages = {
      road-rage = pkgs.callPackage ./road-rage { };
      libfprint-goodixtls-55x4 = pkgs.callPackage ./libfprint-goodixtls-55x4 { };
    };

    # For 'nix fmt'
    formatter = pkgs.nixpkgs-fmt;
  };
}
