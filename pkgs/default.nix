{ pkgs, ... }: {
  minecraft = pkgs.callPackage ./minecraft { };
  road-rage = pkgs.callPackage ./road-rage { };
  wl-ocr = pkgs.callPackage ./wl-ocr { };
}
