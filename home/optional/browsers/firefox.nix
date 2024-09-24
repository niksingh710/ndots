{ inputs, pkgs, lib, config, opts, ... }:
with lib;
let
  cfg = config.hmod.firefox;
  plugins = inputs.firefox-addons.packages.${pkgs.system};
in {
  options.hmod.firefox = {
    plugins = mkEnableOption "Plugins Enabled";
    shyfox = mkEnableOption "Enable Shyfox";
  };
  config = mkMerge [

    {
      programs.firefox = {
        enable = true;
        profiles.default.extraConfig = # js
          ''
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            user_pref("svg.context-properties.content.enabled", true);
            user_pref("layout.css.has-selector.enabled", true);
            user_pref("browser.urlbar.suggest.calculator", true);
            user_pref("browser.urlbar.unitConversion.enabled", true);
            user_pref("browser.urlbar.trimHttps", true);
            user_pref("browser.urlbar.trimURLs", true);
          '';
      };
    }

    (mkIf cfg.plugins {
      programs.firefox.profiles.default.extensions = with plugins; [
        privacy-badger
        vimium-c
        darkreader
        proton-pass
        ublock-origin
        refined-github
        gloc
        enhanced-github
        clearurls
        adaptive-tab-bar-colour
        unpaywall
        simple-translate

        # NOTE: Hacky solution here will change when get time
        (languagetool.overrideAttrs { meta.license = lib.licenses.free; })
        (tampermonkey.overrideAttrs { meta.license = lib.licenses.free; })
        (enhancer-for-youtube.overrideAttrs {
          meta.license = lib.licenses.free;
        })
      ];
    })

    (mkIf cfg.shyfox (let
      src = inputs.firefox-shyfox;
      shyfox = pkgs.runCommand "firefox-chrome-ui" { } ''
        mkdir -p $out
        cp -r ${src}/chrome/* $out
        ln -sf ${opts.wallpaper} $out/wallpaper.png
      '';
    in {
      home.file."chrome" = {
        source = shyfox;
        target =
          "${config.home.homeDirectory}/.mozilla/firefox/default/chrome/";
        recursive = true;

      };
      programs.firefox.profiles.default = {
        extensions = with plugins; [ sidebery userchrome-toggle-extended ];
      };

    }))
  ];
}
