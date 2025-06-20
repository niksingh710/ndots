{
  stdenv,
  fetchurl,
  pkgs,
  lib,
  ...
}:
let
  pname = "orbstack";
  version = "v1.11.3_19358_arm64";

  src = fetchurl {
    url = "https://cdn-updates.orbstack.dev/arm64/OrbStack_${version}.dmg";
    sha256 = "sha256-/zujkmctMdJUm3d7Rjjeic8QrvWSlEAUhjFgouBXeNw=";
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
    cp -r "OrbStack.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
