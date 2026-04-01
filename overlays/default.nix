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
  # TODO: remove the sesh overrdie once updated on nixpkgs
  sesh = prev.buildGoModule {
    pname = "sesh";
    version = "2.20.0-unstable-2026-03-30";
    src = prev.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "sesh";
      rev = "ad3a76e5f0b8e5e9f3e49a7e480a7c87692172d4";
      sha256 = "sha256-azs1tf9eR4MVSdjMdd3U/xdPAANn1Kyamf0TwFrBSTU=";
    };
    vendorHash = "sha256-9IiDp/HaxXQAyNzuVBLiO+oIijBbdKBjssCmj8WV9V4=";
    doCheck = false;
  };

  stremio-enhanced = selfPkgs.stremio-enhanced;
  airsync = selfPkgs.airsync;
  hammerspoon = selfPkgs.hammerspoon;
  road-rage = selfPkgs.road-rage;
  putils =
    (builtins.getFlake "github:niksingh710/utils/efd613813db08fe7a514e1b9cf98f8e06b00f4d5")
    .packages.${prev.stdenv.hostPlatform.system};
}
