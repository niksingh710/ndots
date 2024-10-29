{
  perSystem = { pkgs, ... }: {
    packages = {
      road-rage = pkgs.callPackage ./road-rage { };
      minecraft = pkgs.callPackage ./minecraft { };
      libfprint-goodixtls-55x4 = pkgs.callPackage ./libfprint-goodixtls-55x4 { };
      android-messages-desktop = pkgs.callPackage ./android-messages-desktop { };
    };

    # For 'nix fmt'
    formatter = pkgs.nixpkgs-fmt;
  };
}
