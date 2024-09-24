{ lib, config, pkgs, ... }:
with lib;
let cfg = config.nmod.fonts;
in {
  options.nmod.fonts = {
    extra = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "List of additional fonts to install";
    };
    nerd = mkEnableOption "Nerd Fonts";
    emoji = mkEnableOption "Emoji";
  };

  config =
    let
      emoji = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-extra
      ];
      nerd = with pkgs; [
        carlito
        ipafont
        kochi-substitute
        source-code-pro
        ttf_bitstream_vera
        (nerdfonts.override {
          fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ];
        })
      ];
    in
    {
      fonts = {
        fontconfig.useEmbeddedBitmaps = true;
        packages = [ pkgs.dejavu_fonts pkgs.custom.road-rage ]
          ++ (lib.optionals cfg.emoji emoji) ++ (lib.optionals cfg.nerd nerd);
      };
    };
}
