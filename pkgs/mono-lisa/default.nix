{ stdenv, lib, pkgs, self, ... }:

stdenv.mkDerivation rec {
  pname = "MonoLisa-Script";
  version = "1.0";

  src = "${self}/secrets/enc-font.zip"; # Path to your encrypted zip file
  ageKeyFile = /var/lib/sops/age/keys.txt; # Path to your age key file

  nativeBuildInputs = [ pkgs.sops pkgs.unzip ];

  # Disable the default unpack phase
  unpackPhase = ''
    echo "Skipping default unpack phase"
  '';

  buildPhase = ''
    echo "Copying age key file..."
    tmpdir=$(mktemp -d)
    cp ${ageKeyFile} "$tmpdir/age-key.txt"

    echo "Decrypting the zip file..."
    export SOPS_AGE_KEY_FILE=$tmpdir/age-key.txt
    sops -d $src > decrypted_fonts.zip
    echo "Decryption successful."

    echo "Unzipping the decrypted fonts..."
    unzip decrypted_fonts.zip -d decrypted_fonts
    rm -rf "$tmpdir"
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/custom
    cp -r decrypted_fonts/monolisa-script/* $out/share/fonts/truetype/custom/
  '';

  meta = {
    description = "MonoLisa Script font (licensed)";
    license = lib.licenses.unfree; # Change this according to your font's license
    platforms = lib.platforms.linux;
  };
}
