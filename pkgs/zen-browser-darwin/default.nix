# Packaged appimage till the build time on nixpkgs reduced.
# https://github.com/NixOS/nixpkgs/issues/327982
{
  stdenv,
  fetchurl,
  pkgs,
  lib,
  ...
}:
let
  pname = "zen";
  version = "1.12.10b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-universal.dmg";
    sha256 = "sha256:75c27e278870a48749134edfc84706f04ec272c0cd11c4baab7d320ba17db8ca"; # Remember as in url `/latest/` is used the sha256 will change with releases.
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
  ];

  unpackPhase = ''
    undmg $src
  '';
  installPhase = ''
    set -x  # Enables command tracing
    mkdir -p $out/Applications
    ls >&2
    cp -r "Zen.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
