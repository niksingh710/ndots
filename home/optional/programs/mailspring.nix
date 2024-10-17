{ pkgs, inputs, config, ... }:
let
  inherit (config.lib.stylix) colors;
  stylix-issac = pkgs.stdenv.mkDerivation {
    name = "stylix-issac";
    src = inputs.mailspring-theme;
    installPhase = ''
      mkdir -p $out/
      cp -r $src/* $out
    '';
    postFixup = with colors;''
      rm $out/*.png
      rm $out/*.md
      rm $out/LICENSE

      echo -n "" > $out/styles/variables.less
      cat <<EOF > $out/styles/variables.less
        @isaac-dark: #${base00};
        @isaac-light: #${base0F};
        @isaac-lighter: lighten(@isaac-light, 10%);
        @isaac-accent: #${base01};
        @white: #ffffff;
        @black: #000000;
        @isaac-yellow: #ffd100;
        @isaac-orange: #ff7b00;
        @isaac-error: #ff5050;
        @text-color: #${base0B};
        @text-color-link: @isaac-accent;
        @text-color-link-hover: lighten(@isaac-accent, 10%);
        @base-border-radius: 2px;
      EOF

    '';
  };
  args = [
    "--password-store=\"gnome-libsecret\""
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
  ];
in
{
  persist.dir = [ ".config/Mailspring" ];
  home.file."stylix theme for mailspring" = {
    source = stylix-issac;
    target = ".config/Mailspring/packages/stylix-issac";
    recursive = true; # Copy the directory recursively
  };
  home.packages = [
    (pkgs.symlinkJoin
      {
        name = "mailspring";
        paths = [
          (pkgs.mailspring.overrideAttrs (oa: {
            postFixup = ''
              substituteInPlace $out/share/applications/Mailspring.desktop \
                --replace-fail Exec=mailspring Exec="$out/bin/mailspring ${builtins.concatStringsSep " " args}"
            '';
          }))
        ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/mailspring \
            --add-flags "${builtins.concatStringsSep " " args}"
        '';
      })
  ];
}
