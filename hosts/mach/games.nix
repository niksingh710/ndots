{ self, config,... }:
{
  imports = [
    self.nixosModules.games
  ];

  hm = {
    home.file.".minecraft/sklauncher/sklauncher.json".text = /* json */ ''
      {
        "lang": "en-US",
        "theme": "dark",
        "accentColor": "#${config.lib.stylix.colors.base0D}",
        "consoleEnabled": false,
        "hideDefaultProfiles": false,
        "performanceMode": false,
        "allowXmxArgs": false,
        "forceNativeTitlebar": false,
        "useNewTitlebar": false,
        "forceDedicatedGPU": true,
        "showLoginDebug": false,
        "enableDiscordRPC": true
      }
    '';
    persist = {
      dir = [
        ".local/share/Steam"
        ".steam"
        ".config/heroic"
        ".config/unity3d"
        ".config/supertuxkart"
        ".minecraft"
      ];
    };
  };

  nmod.games = {
    steam.enable = true;
    heroic.enable = true;
    minecraft.enable = true; # this will get SKLauncher
  };

}
