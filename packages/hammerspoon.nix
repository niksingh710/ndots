{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
}:
stdenvNoCC.mkDerivation (self: {
  pname = "hammerspoon";
  version = "1.1.1";

  src = fetchurl {
    name = "${self.pname}-${self.version}-source.zip";
    url = "https://github.com/Hammerspoon/hammerspoon/releases/download/${self.version}/Hammerspoon-${self.version}.zip";
    sha256 = "sha256-EbsckPr1Qn83x71P5+q5d0rkPh1csCDFswiNrDKEnvo=";
  };

  nativeBuildInputs = [
    unzip
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/Applications
    cp -r ../Hammerspoon.app $out/Applications/
    runHook postInstall
  '';

  meta = {
    homepage = "https://www.hammerspoon.org";
    description = "Staggeringly powerful macOS desktop automation with Lua";
    license = lib.licenses.mit;
    platforms = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
})
