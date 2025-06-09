{ pkgs, ... }:
{
  minecraft = pkgs.callPackage ./minecraft { };
  road-rage = pkgs.callPackage ./road-rage { };
  wl-ocr = pkgs.callPackage ./wl-ocr { };
  zen-browser-appimage = pkgs.callPackage ./zen-browser-appimage { };
  zen-browser-darwin = pkgs.callPackage ./zen-browser-darwin { };
  the-boring-notch = pkgs.callPackage ./the-boring-notch { };
}
