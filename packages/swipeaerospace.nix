{ pkgs, lib, stdenv, fetchurl }:
stdenv.mkDerivation {
  pname = "swipeaerospace";
  version = "0.2.2";
  src = fetchurl {
    url = "https://github.com/MediosZ/SwipeAeroSpace/releases/download/0.2.2/SwipeAeroSpace.dmg";
    sha256 = "sha256-CWrQiNXQh4c9pNlJGzLzycfx6W4paZG/2iUhBhAikTw=";
  };

  phases = [
    "unpackPhase"
    "installPhase"
  ];

  nativeBuildInputs = with pkgs;[
    undmg
    makeWrapper
    copyDesktopItems
  ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    set -x  # Enables command tracing
    mkdir -p $out/Applications
    ls >&2
    cp -r "SwipeAeroSpace.app" $out/Applications/
    set +x  # Disables command tracing when you're done
  '';

  meta = with lib; {
    description = "Trackpad gesture swipe aerospace workspace";
    homepage = "https://github.com/MediosZ/SwipeAeroSpace";
    license = licenses.mit;
    maintainers = with maintainers; [ niksingh710 ];
    platforms = platforms.darwin;
    mainProgram = "swipeaerospace";
    broken = false; # Set to true if the package is known to be broken
  };
}
