{ pkgs, ... }:
let
  # pick any name from <https://tinted-theming.github.io/tinted-gallery/>
  # if base16Scheme is not set the color from wallpapers will be used
  scheme = "catppuccin-mocha";
in
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    image = pkgs.fetchurl {
      url = "https://github.com/user-attachments/assets/2a7e45d5-27d9-4e1c-a950-293829592f65";
      sha256 = "sha256-EJsuZ2LvFzSQztHdTkcEW+MkA2irTwTXLog1aqVocF4=";
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
