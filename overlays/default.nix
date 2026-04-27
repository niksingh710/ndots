{ inputs, ... }:
final: prev:
let
  inherit (inputs) self;
  selfPkgs = self.packages.${final.stdenv.hostPlatform.system};
in
{
  stable = import inputs.nixpkgs-stable {
    allowUnfree = true;
    inherit (prev.stdenv.hostPlatform) system;
    overlays = prev.lib.attrValues inputs.self.overlays;
  };
  nsearch-adv = inputs.nsearch.packages.${final.stdenv.hostPlatform.system}.nsearch-adv;
  stremio-enhanced = selfPkgs.stremio-enhanced;
  airsync = selfPkgs.airsync;
  hammerspoon = selfPkgs.hammerspoon;
  road-rage = selfPkgs.road-rage;
  putils =
    (builtins.getFlake "github:niksingh710/utils/efd613813db08fe7a514e1b9cf98f8e06b00f4d5")
    .packages.${prev.stdenv.hostPlatform.system};
}
