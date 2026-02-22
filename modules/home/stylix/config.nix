{ pkgs, ... }:
let
  # pick any name from <https://tinted-theming.github.io/tinted-gallery/>
  # if base16Scheme is not set the color from wallpapers will be used
  scheme = "kanagawa-dragon";
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/photography/beach.png";
      sha256 = "sha256-Uym/931m4K6JQDOJdSYuF2bglYGtGDUD/Qm8yY0xw3s=";
    };
    override = {
      base00 = "000000";
    };
    opacity.terminal = 0.4;
    polarity = "dark";
    fonts.monospace = {
      name = "Monaspace Radon Var";
      package = pkgs.monaspace;
    };
  };
}
