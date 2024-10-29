{ lib, appimageTools, fetchurl, makeDesktopItem }:
# Only available for x86_64-linux
let
  version = "5.4.5";
  pname = "android-messages-desktop";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/OrangeDrangon/android-messages-desktop/releases/download/v${version}/Android-Messages-v${version}-linux-x86_64.AppImage";
    sha256 = "sha256-Hi93+fJiL+994pBpZBznPHthQ0Gz6oipkm0TAqyzB4M=";
  };

  desktopItem = makeDesktopItem {
    # inherit icon;
    name = "Messages";
    exec = "${pname} --enable-features=UseOzonePlatform --ozone-platform=wayland";
    desktopName = "Android Messages";
    categories = [ "Network" ];
    keywords = [ "messages" "google messages" "sms" ];
  };

  appimageContents = appimageTools.extractType1 { inherit name src; };
in
appimageTools.wrapType1 {
  inherit name src;

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    cp -r ${desktopItem}/share/* $out/share
  '';

  meta = {
    description = "Android Messages as a desktop app, in a standalone app";
    homepage = "https://github.com/OrangeDrangon/android-messages-desktop";
    downloadPage = "https://github.com/OrangeDrangon/android-messages-desktop/releases";
    license = lib.licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ niksingh710 ];
    platforms = [ "x86_64-linux" ];
  };
}
