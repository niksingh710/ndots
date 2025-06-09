{
  stdenv,
  fetchurl,
  pkgs,
  lib,
  ...
}:
let
  pname = "the-boring-notch";
  version = "wolf.painting";
  name = "WolfPainting";

  src = fetchurl {
    url = "https://github.com/TheBoredTeam/boring.notch/releases/download/${version}/${name}.dmg";
    sha256 = "1a58ec27e5de30faf107fdf8b77575b1c39ace69e77b1330fc4ed6562bf2badc";
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
    cp -r "boringNotch.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
