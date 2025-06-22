{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
final: prev: {
  stable = import inputs.nixpkgs-stable {
    allowUnfree = true;
    overlays = prev.lib.attrValues self.overlays;
  };
}
