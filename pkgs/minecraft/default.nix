{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "nminecraft";
  version = "3.2.12";

  src = pkgs.fetchurl {
    url = "https://skmedix.pl/binaries/skl/${version}/SKlauncher-${version}.jar";
    sha256 = "a3912e1e9b4e3b2d5362c91176444c7d5b1a15437cb827f123e4ca2b0d12c3f9";
  };

  nativeBuildInputs = [ pkgs.copyDesktopItems ];

  phases = [
    "installPhase"
    "copyDesktopItems"
  ];

  jvmOptions = [
    "-Xms2G" # Set minimum heap size to 2GB
    "-Xmx16G" # Set maximum heap size to 4GB
  ];

  installPhase = ''
    # shellcheck disable=SC2154

    # Create the destination bin directory for the nminecraft binary
    mkdir -p "$out/bin"

    # Copy the jar file into the package
    mkdir -p "$out/share/sklauncher"
    cp "$src" "$out/share/sklauncher/SKlauncher.jar"

    # Create a shell script to run the jar file using java
    cat > "$out/bin/nminecraft" <<EOF
    #!/bin/sh

    # Default JVM options from the derivation
    DEFAULT_JVM_OPTS="${toString jvmOptions}"

    # Run the SKLauncher jar with user-specified Java options and other arguments
    exec \
    ${lib.getExe pkgs.steam-run} \
    ${lib.getExe' pkgs.jetbrains.jdk "java"} \
    \$DEFAULT_JVM_OPTS \
    "\$@" \
    -jar $out/share/sklauncher/SKlauncher.jar

    EOF

    # Make the script executable
    chmod +x "$out/bin/nminecraft"
  '';

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "SkLauncher";
      exec = "nminecraft";
      icon = "minecraft-launcher";
      desktopName = "SKLauncher";
      genericName = "A Minecraft Launcher";
      categories = [ "Game" ];
    })
  ];

  meta = with lib; {
    description = "Minecraft launcher using SKLauncher";
    homepage = "https://skmedix.pl/";
    license = licenses.unfree; # Since it's a proprietary binary
    maintainers = [ maintainers.niksingh710 ];
    mainProgram = "nminecraft";
  };
}
