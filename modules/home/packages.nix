# Not meant to be imported by other user
# but can use if you understand and need these
# some packages are might be coming from my overlays
# Most of the packages are ui based.
# if cli based increases then a dir/{cli.nix, default.nix} can be created
# with partial import
{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;

  both = with pkgs; [
    telegram-desktop
    omnix
    google-chrome
    youtube-music
    postman
    zoom-us
  ];

  linux = lib.optionals isLinux (
    with pkgs;
    [
      zulip
      mailspring
    ]
  );
  darwin = lib.optionals isDarwin (
    with pkgs;
    [
      ice-bar
      keycastr
      mas
      numi
      tart
      utm
      airsync
    ]
  );

in
{
  home.packages = linux ++ darwin ++ both;

  imports = [
    inputs.nixcord.homeModules.nixcord
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
