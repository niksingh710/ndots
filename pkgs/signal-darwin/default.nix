{
  stdenv,
  fetchurl,
  pkgs,
  lib,
  ...
}:
let
  pname = "signal";
  version = "7.57.0";

  src = fetchurl {
    url = "https://updates.signal.org/desktop/signal-desktop-mac-universal-${version}.dmg";
    sha256 = "sha256-dGZde/yihXjNwF6oRTghDuKREE6g522wFETVUVA+NLY="; # Remember as in url `/latest/` is used the sha256 will change with releases.
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
    _7zz
  ];

  unpackPhase = ''
    7zz x -snld $src
  '';
  installPhase = ''
    set -x  # Enables command tracing
    mkdir -p $out/Applications
    ls >&2
    cp -r "Signal.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
