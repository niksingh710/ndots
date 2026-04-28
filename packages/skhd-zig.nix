{
  lib,
  stdenvNoCC,
  fetchurl,
  gnutar,
}:
let
  version = "0.0.24";
  baseUrl = "https://github.com/jackielii/skhd.zig/releases/download/v${version}";

  sources = {
    "aarch64-darwin" = {
      url = "${baseUrl}/skhd-arm64-macos.tar.gz";
      hash = "sha256-z8kcHm+fbreKLdGlZQAW/BMvPcDkbGhXZzL4g444+t0=";
    };
    "x86_64-darwin" = {
      url = "${baseUrl}/skhd-x86_64-macos.tar.gz";
      hash = lib.fakeHash;
    };
  };

  source =
    sources.${stdenvNoCC.hostPlatform.system}
      or (throw "skhd-zig: unsupported system ${stdenvNoCC.hostPlatform.system}");
in
stdenvNoCC.mkDerivation {
  pname = "skhd-zig";
  inherit version;

  src = fetchurl {
    inherit (source) url hash;
  };

  nativeBuildInputs = [ gnutar ];

  unpackPhase = ''
    runHook preUnpack
    tar -xzf $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    binary=$(find . -name skhd -type f | head -n 1)
    if [ -z "$binary" ]; then
      echo "skhd-zig: could not locate skhd binary in tarball" >&2
      exit 1
    fi
    install -m755 "$binary" $out/bin/skhd
    runHook postInstall
  '';

  meta = {
    description = "Zig port of skhd, fully .skhdrc compatible";
    homepage = "https://github.com/jackielii/skhd.zig";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    mainProgram = "skhd";
  };
}
