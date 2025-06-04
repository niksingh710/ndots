{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];
  home.packages =
    with pkgs;
    [
      telegram-desktop
      zoom-us
      slack
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      zulip
      nitch
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
