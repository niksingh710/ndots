{ pkgs, ... }:
let
  pname = "airsync-mac";
  version = "2.0.31-BETA";

  src = pkgs.fetchurl {
    url = "https://github.com/sameerasw/${pname}/releases/download/v${version}/AirSync.dmg";
    sha256 = "sha256:ae5f2ea581f874c98e6e201c5018bab132b0a2c0adfa9b635401e1568d868824";
  };
in
with pkgs;
stdenv.mkDerivation {
  inherit pname version src;
  phases = [
    "unpackPhase"
    "installPhase"
  ];
  nativeBuildInputs = with pkgs; [
    makeWrapper
    copyDesktopItems
    undmg
  ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    set -x  # Enables command tracing
    mkdir -p $out/Applications
    ls >&2
    cp -r "AirSync.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
