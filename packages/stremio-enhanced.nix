{ pkgs, ... }:
let
  pname = "stremio-enhanced";
  version = "1.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/REVENGE977/${pname}/releases/download/v${version}/mac-arm64.zip";
    sha256 = "sha256:342fdcf0ec3c040511edcad538682dec10f94a405d328b3bea43a464298f7003";
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
    unzip
    fd
  ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    set -x  # Enables command tracing
    mkdir -p $out/Applications
    ls >&2
    cp -r "mac-arm64/Stremio Enhanced.app" $out/Applications/
    chmod +x $out/Applications/Stremio\ Enhanced.app/Contents/MacOS/*
    fd . "$out/Applications/Stremio Enhanced.app/Contents/Frameworks" -t f -x chmod +x {}
    set +x  # Disables command tracing when you're done
  '';
  meta.platforms = lib.platforms.darwin;
}
