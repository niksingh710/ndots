# Packaged appimage till the build time on nixpkgs reduced.
# https://github.com/NixOS/nixpkgs/issues/327982
{ appimageTools, fetchurl, ... }:
let
  pname = "zen";
  version = "latest";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen-x86_64.AppImage";
    sha256 = "sha256-1NoDIdzeADVLOhtesR0QZefhAdRBSNWg4++MjqdkfIs="; # Remember as in url `/latest/` is used the sha256 will change with releases.
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    # Install .desktop file
    install -m 444 -D ${appimageContents}/zen.desktop $out/share/applications/${pname}.desktop
    # Install icon
    install -m 444 -D ${appimageContents}/zen.png $out/share/icons/hicolor/128x128/apps/${pname}.png
  '';


  meta.platforms = [ "x86_64-linux" ];

}
