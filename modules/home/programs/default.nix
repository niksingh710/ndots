{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];
  home.packages = with pkgs;[
    telegram-desktop
    nitch
    zulip
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
