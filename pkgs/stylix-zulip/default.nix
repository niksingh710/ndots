{
  pkgs,
  inputs,
  colors,
  ...
}:

pkgs.stdenv.mkDerivation {
  name = "stylix-zulip";
  src = inputs.zulip-theme;
  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out
  '';
  postFixup = with colors; ''
    rm $out/*.md
    rm $out/LICENSE

    cat <<EOF >> $out/zulip.css
      :root {
        --background-primary: #${base00};
        --background-secondary: #${base02};
        --background-tertiary: #${base03};
        --channeltextarea-background: #${base04};
        --scrollbar-auto-thumb: #${base01};
      }
    EOF

  '';
}
