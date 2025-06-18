{
  stdenv,
  fetchurl,
  pkgs,
  lib,
  ...
}:
let
  pname = "flipqo";
  version = "1.9.4";

  src = fetchurl {
    url = "https://fliqlo.com/download/Fliqlo%20${version}.dmg";
    sha256 = "sha256-rZuXEidJjvht1SONvjtXNgSdufLet6YzWNUbTEDsEY4="; # Remember as in url `/latest/` is used the sha256 will change with releases.
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
    7zz x -snld "$src"
  '';
  installPhase = ''
    set -x  # Enables command tracing
    mkdir -p $out/Applications
    ls >&2
    cp -r "Flipqo.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
