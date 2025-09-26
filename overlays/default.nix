{ inputs, ... }:
final: prev:
let
  inherit (inputs) self;
  selfPkgs = self.packages.${final.system};
in
{
  stable = import inputs.nixpkgs-stable {
    allowUnfree = true;
    inherit (prev) system;
    overlays = prev.lib.attrValues inputs.self.overlays;
  };
  nsearch-adv = inputs.nsearch.packages.${final.system}.nsearch-adv;
  stremio-enhanced = selfPkgs.stremio-enhanced;
  airsync = selfPkgs.stremio-enhanced;
  utils =
    (builtins.getFlake "github:niksingh710/utils/efd613813db08fe7a514e1b9cf98f8e06b00f4d5")
    .packages.${prev.system};
}
