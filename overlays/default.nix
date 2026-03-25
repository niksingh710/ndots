{ inputs, ... }:
final: prev:
let
  inherit (inputs) self;
  selfPkgs = self.packages.${final.stdenv.hostPlatform.system};
in
{
  # TODO: <https://github.com/NixOS/nixpkgs/pull/502769> till this get's merged in nixpkgs-unstable
  direnv = prev.direnv.overrideAttrs (old: {
    postPatch = ''
      substituteInPlace GNUmakefile --replace-fail " -linkmode=external" ""
    '';
  });

  stable = import inputs.nixpkgs-stable {
    allowUnfree = true;
    inherit (prev.stdenv.hostPlatform) system;
    overlays = prev.lib.attrValues inputs.self.overlays;
  };
  nsearch-adv = inputs.nsearch.packages.${final.stdenv.hostPlatform.system}.nsearch-adv;
  # TODO: Once the Pr is merged we can remove this override
  # <https://github.com/NixOS/nixpkgs/pull/493232>
  fzf-preview = prev.fzf-preview.overrideAttrs (old: {
    src = prev.fetchFromGitHub {
      owner = "niksingh710";
      repo = "fzf-preview";
      rev = "5e5a5a5c4258fa86300cb56224e31416ff7401b5";
      sha256 = "sha256-ZjBoTsZ2ymfhmUbMpMWT1MB20kLf0BILnCDu75F6WEQ=";
    };
  });
  stremio-enhanced = selfPkgs.stremio-enhanced;
  airsync = selfPkgs.airsync;
  hammerspoon = selfPkgs.hammerspoon;
  road-rage = selfPkgs.road-rage;
  putils =
    (builtins.getFlake "github:niksingh710/utils/efd613813db08fe7a514e1b9cf98f8e06b00f4d5")
    .packages.${prev.stdenv.hostPlatform.system};
}
