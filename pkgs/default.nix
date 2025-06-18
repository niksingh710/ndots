{ pkgs, ... }:
{
  crystal-fetch = pkgs.callPackage ./crystal-fetch { };
  minecraft = pkgs.callPackage ./minecraft { };
  road-rage = pkgs.callPackage ./road-rage { };
  wl-ocr = pkgs.callPackage ./wl-ocr { };
  zen-browser-appimage = pkgs.callPackage ./zen-browser-appimage { };
  zen-browser-darwin = pkgs.callPackage ./zen-browser-darwin { };
  the-boring-notch = pkgs.callPackage ./the-boring-notch { };
  pronotes = pkgs.callPackage ./pronotes { };
  flipqo = pkgs.callPackage ./flipqo { };
  signal = pkgs.callPackage ./signal-darwin { };
}
