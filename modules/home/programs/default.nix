{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  home.packages = with pkgs; [
    telegram-desktop
    nitch
    zulip
    zoom-us
    slack
    mailspring
  ];

  programs.nixcord = {
    enable = true;
    config = {
      useQuickCss = true;
      frameless = true;
      plugins = {
        messageLogger = {
          enable = true;
          collapseDeleted = true;
        };
        showMeYourName.enable = true;
        fakeNitro.enable = true;
      };
    };
  };
}
