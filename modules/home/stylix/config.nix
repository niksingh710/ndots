{ pkgs, ... }:
let
  # pick any name from <https://tinted-theming.github.io/tinted-gallery/>
  # if base16Scheme is not set the color from wallpapers will be used
  scheme = "gruvbox-dark-hard";
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/gruv-understand.png";
      sha256 = "0111fc2553d6a972fa06bce25d766554572c19637ca3904bb99ced044210168e";
    };
    opacity.terminal = 0.4;
    polarity = "dark";
    fonts.monospace = {
      name = "Monaspace Radon Var";
      package = pkgs.monaspace;
    };
  };
}
