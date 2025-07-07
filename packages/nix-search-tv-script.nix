{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, fzf
, gnused
, gawk
, nix-search-tv
, xdg-utils
, bash
}:

stdenv.mkDerivation {
  pname = "nix-search-tv";
  version = "0.1.0"; # Adjust version as needed

  src = fetchFromGitHub {
    owner = "3timeslazy";
    repo = "nix-search-tv";
    rev = "62da5aff52cc196f1e97e5692dd17b466505448a";
    sha256 = "sha256-TyniXPYrSy7m3+WxHKN/pXWVpG4UqwwC/RUMSLaQYRU="; # You'll need to fill this in or use lib.fakeSha256
  };

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ bash ];

  propagatedBuildInputs = [
    fzf
    gnused
    gawk
    xdg-utils
  ];

  installPhase = ''
    runHook preInstall

    # Create bin directory
    mkdir -p $out/bin

    # Copy and modify the script
    cp nixpkgs.sh "$out/bin/nixpkgs"

    # Replace "all ctrl-a" with "all alt-a"
    sed -i 's/"all ctrl-a"/"all alt-a"/g' $out/bin/nixpkgs

    # Make it executable
    chmod +x $out/bin/nixpkgs

    # Wrap the script to ensure dependencies are available
    wrapProgram $out/bin/nixpkgs \
      --prefix PATH : ${lib.makeBinPath [ fzf gnused gawk nix-search-tv xdg-utils ]}

    runHook postInstall
  '';

  meta = with lib; {
    description = "Interactive Nix package search with fzf";
    homepage = "https://github.com/3timeslazy/nix-search-tv";
    license = licenses.mit; # Adjust if different
    maintainers = [ maintainers.niksingh710 ]; # Add your name if you want
    platforms = platforms.unix;
    mainProgram = "nixpkgs";
  };
}
