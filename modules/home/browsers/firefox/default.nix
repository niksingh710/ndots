{ lib, inputs, pkgs, ... }: with lib;
let
  plugins = inputs.firefox-addons.packages.${pkgs.system};
in
{
  options.ndots.browser.firefox = {
    textfox = mkEnableOption "Enable textfox" // { default = true; };
  };
  config.programs.firefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    profiles.default = {
      extraConfig = # js
        ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("svg.context-properties.content.enabled", true);
          user_pref("layout.css.has-selector.enabled", true);
          user_pref("browser.urlbar.suggest.calculator", true);
          user_pref("browser.urlbar.unitConversion.enabled", true);
          user_pref("browser.urlbar.trimHttps", true);
          user_pref("browser.urlbar.trimURLs", true);
        '';
      extensions = with plugins; [
        privacy-badger
        vimium-c
        darkreader
        proton-pass
        ublock-origin
        refined-github
        enhanced-github
        clearurls
        adaptive-tab-bar-colour
        unpaywall
        simple-translate
        pwas-for-firefox
        qr-code-address-bar

        # HACK: Hacky solution here will change when get time
        (languagetool.overrideAttrs { meta.license = lib.licenses.free; })
        (tampermonkey.overrideAttrs { meta.license = lib.licenses.free; })
        (enhancer-for-youtube.overrideAttrs {
          meta.license = lib.licenses.free;
        })
      ];

    };
  };

  imports = with builtins;
    map (fn: ./${fn})
      (filter
        (fn: (
          fn != "default.nix"
          && !hasSuffix ".md" "${fn}"
        ))
        (attrNames (readDir ./.)));
}
