{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
final: prev: {
  stable = import inputs.nixpkgs-stable {
    allowUnfree = true;
    inherit (prev) system;
    overlays = prev.lib.attrValues self.overlays;
  };
  swipeaerospace = prev.callPackage "${packages}/swipeaerospace.nix" { };
  nvix = inputs.nvix.packages.${prev.system}.core.extend {
    config.vimAlias = true;
  };
}
