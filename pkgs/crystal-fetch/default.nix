{
  stdenv,
  fetchurl,
  pkgs,
  lib,
  ...
}:
let
  pname = "CrystalFetch";
  version = "v2.2.0";

  src = fetchurl {
    url = "https://github.com/TuringSoftware/CrystalFetch/releases/download/${version}/CrystalFetch.dmg";
    sha256 = "sha256-bkKKQZvF3t7SHaDJ6vrkUH/VsvtuLIz4tZ+XUi8B3u4="; # Remember as in url `/latest/` is used the sha256 will change with releases.
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
    cp -r "CrystalFetch.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
