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
  airsync = selfPkgs.airsync;
  # FIX: once gtk3+ builds fine on `nixpkgs-unstable` update nixpkgs
  # Tracker: <https://github.com/NixOS/nixpkgs/pull/449689>
  yabai = prev.yabai.overrideAttrs (oldAttrs: rec {
    version = "7.1.16";

    src =
      if prev.stdenv.hostPlatform.system == "aarch64-darwin" then
        prev.fetchzip {
          url = "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
          hash = "sha256-rEO+qcat6heF3qrypJ02Ivd2n0cEmiC/cNUN53oia4w=";
        }
      else
        prev.fetchFromGitHub {
          owner = "koekeishiya";
          repo = "yabai";
          rev = "v${version}";
          hash = "sha256-WXvM0ub4kJ3rKXynTxmr2Mx+LzJOgmm02CcEx2nsy/A=";
        };
  });
  jankyborders = prev.jankyborders.overrideAttrs (oa: rec {
    version = "1.8.4";

    src = prev.fetchFromGitHub {
      owner = "FelixKratz";
      repo = "JankyBorders";
      rev = "v${version}";
      hash = "sha256-31Er+cUQNJbZnXKC6KvlrBhOvyPAM7nP3BaxunAtvWg=";
    };
  });
  utils =
    (builtins.getFlake "github:niksingh710/utils/efd613813db08fe7a514e1b9cf98f8e06b00f4d5")
    .packages.${prev.system};
}
