{ config, ... }:
let inherit (config.lib.stylix) colors;
in {
  home.file.".config/darkreader/config.json".text = # json
    ''
      {
        "schemeVersion": 2,
        "enabled": true,
        "fetchNews": true,
        "theme": {
          "mode": 1,
          "brightness": 100,
          "contrast": 100,
          "grayscale": 0,
          "sepia": 0,
          "useFont": false,
          "fontFamily": "Open Sans",
          "textStroke": 0,
          "engine": "dynamicTheme",
          "stylesheet": "",
          "darkSchemeBackgroundColor": "#${colors.base00}",
          "darkSchemeTextColor": "#${colors.base0F}",
          "lightSchemeBackgroundColor": "#${colors.base0F}",
          "lightSchemeTextColor": "#${colors.base00}",
          "scrollbarColor": "auto",
          "selectionColor": "auto",
          "styleSystemControls": false,
          "lightColorScheme": "Default",
          "darkColorScheme": "Default",
          "immediateModify": false
        },
        "presets": [],
        "customThemes": [],
        "enabledByDefault": true,
        "enabledFor": [],
        "disabledFor": [],
        "changeBrowserTheme": false,
        "syncSettings": false,
        "syncSitesFixes": true,
        "automation": {
          "enabled": false,
          "mode": "",
          "behavior": "OnOff"
        },
        "time": {
          "activation": "18:00",
          "deactivation": "9:00"
        },
        "location": {
          "latitude": null,
          "longitude": null
        },
        "previewNewDesign": true,
        "enableForPDF": true,
        "enableForProtectedPages": true,
        "enableContextMenus": false,
        "detectDarkTheme": false,
        "displayedNews": [
          "thanks-2023"
        ]
      }
    '';
}
