{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  system.stateVersion = 6;
  nix.nixPath = [
    "nixpkgs=${inputs.nixpkgs}"
  ];
  nixpkgs.overlays = [
    (next: prev: {
      stable = import inputs.nixpkgs-stable {
        # This allows me to use `pkgs.stable`
        inherit (prev) system;
        config.allowUnfree = true;
      };
    })
  ];
  hm.home = {
    shellAliases.fetch = "${lib.getExe pkgs.fastfetch} -c examples/17.jsonc --kitty-icat $HOME/.logo.png --logo-width 16 --logo-padding-right 3";
    file."logo" = {
      source = pkgs.fetchurl {
        url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Apple_logo_grey.svg/1010px-Apple_logo_grey.svg.png";
        sha256 = "sha256-K+9hw2uFiRa81RCyOvqzrsZtebBQBQVwle1fvEVWj1o=";
      };
      target = "${config.hm.home.homeDirectory}/.logo.png";
    };
  };
}
