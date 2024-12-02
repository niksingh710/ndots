{ lib, config, pkgs, self, ... }:
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
      ] ++ (with nerd-fonts;
        [ jetbrains-mono fira-code droid-sans-mono ]);
    in
    {
      fonts = mkMerge [{
        fontconfig.useEmbeddedBitmaps = true;
        packages = [ pkgs.dejavu_fonts pkgs.custom.road-rage ]
          ++ (lib.optionals cfg.emoji emoji) ++ (lib.optionals cfg.nerd nerd);
      }
        (mkIf config.nmod.sops.enable {
          packages = [ (pkgs.callPackage "${self}/pkgs/mono-lisa" { inherit self; }) ];
        })];
    };
}
