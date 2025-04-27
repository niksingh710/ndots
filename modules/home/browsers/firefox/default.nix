{
  lib,
  inputs,
  pkgs,
  self,
  ...
}:
with lib;
let
  plugins = inputs.firefox-addons.packages.${pkgs.system};
  cfgFirefox = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    policies = {
      SanitizeOnShutdown = {
        Cache = false;
        Cookies = false;
        History = false;
        Sessions = false;
        SiteSettings = false;
        Locked = true;
      };
    };
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
      extensions.packages = with plugins; [
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
in
{
  options.ndots.browser.firefox = {
    textfox = mkEnableOption "Enable textfox" // {
      default = true;
    };
  };
  config = {
    home.packages = [ self.packages.${pkgs.system}.zen-browser-appimage ];
    programs.librewolf = cfgFirefox // {
      # enable = false; # till build time get's fixed
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "identity.fxaccounts.enabled" = true;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.downloads" = false;
      };
    };
    programs.firefox = cfgFirefox;
  };

  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}
