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
      tmate
      tailscale
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      zulip
      nitch
      mailspring
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      ice-bar
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
