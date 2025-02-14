{ lib, pkgs, self, config, ... }: with lib;
{
  hm.home.packages = [ (pkgs.callPackage "${self}/pkgs/minecraft" { }) ];
  hm.home.file.".minecraft/sklauncher/sklauncher.json".text = /* json */ ''
    {
      "lang": "en-US",
      "theme": "dark",
      "accentColor": "#${config.lib.stylix.colors.base06}",
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
  programs = {
    gamemode.enable = true;
    gamescope.enable = true;
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
