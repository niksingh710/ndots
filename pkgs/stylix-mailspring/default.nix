{
  pkgs,
  inputs,
  colors,
  ...
}:

pkgs.stdenv.mkDerivation {
  name = "stylix-issac";
  src = inputs.mailspring-theme;
  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out
  '';
  postFixup = with colors; ''
    rm $out/*.png
    rm $out/*.md
    rm $out/LICENSE

    echo -n "" > $out/styles/variables.less
    cat <<EOF > $out/styles/variables.less
      @isaac-dark: #${base00};
      @isaac-light: #${base06};
      @isaac-lighter: lighten(@isaac-light, 10%);
      @isaac-accent: #${base0F};
      @white: #ffffff;
      @black: #000000;
      @isaac-yellow: #ffd100;
      @isaac-orange: #ff7b00;
      @isaac-error: #ff5050;
      @text-color: #${base05};
      @text-color-link: @isaac-accent;
      @text-color-link-hover: lighten(@isaac-accent, 10%);
      @base-border-radius: 2px;

      .message-item-white-wrap {
        background: @isaac-dark !important;
      }
      div.sidebar-participant-picker {
        color: @text-color !important;
      }
    EOF

  '';
}
