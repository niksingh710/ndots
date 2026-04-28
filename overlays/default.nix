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
  skhd-zig = selfPkgs.skhd-zig;
  putils =
    (builtins.getFlake "github:niksingh710/utils/efd613813db08fe7a514e1b9cf98f8e06b00f4d5")
    .packages.${prev.stdenv.hostPlatform.system};

  # Fix appstream build on Darwin: meson's pthread detection returns "none required"
  # which gets passed to the linker as separate arguments.
  appstream = prev.appstream.overrideAttrs (oldAttrs: {
    # Use perl to patch build.ninja - more reliable than sed for this pattern
    postConfigure =
      (oldAttrs.postConfigure or "")
      + prev.lib.optionalString prev.stdenv.hostPlatform.isDarwin ''
        # Patch build.ninja to remove "none required"
        find . -name "build.ninja" -type f -exec ${prev.perl}/bin/perl -i -pe 's/\s+none\s+required//g' {} \;
      '';

    # Disable compose for now to simplify the build
    mesonFlags =
      (oldAttrs.mesonFlags or [ ])
      ++ prev.lib.optional prev.stdenv.hostPlatform.isDarwin "-Dcompose=false";
  });
}
