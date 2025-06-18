{
  stdenv,
  fetchurl,
  pkgs,
  lib,
  ...
}:
let
  pname = "pronotes";
  version = "0.7.7";

  src = fetchurl {
    url = "https://pronotes.app/direct-download";
    sha256 = "sha256-WC73x1nkmVJV71He1VMsBFwyPn2S4eYHH+jgjjOpVQ0=";
  };
in
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
    unzip
  ];

  unpackPhase = ''
    unzip $src
  '';
  installPhase = ''
    set -x  # Enables command tracing
    mkdir -p $out/Applications
    ls >&2
    cp -r "ProNotes.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
