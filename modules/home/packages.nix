{ flake, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (pkgs.stdenv) isDarwin isLinux;

  both = with pkgs;[
    stable.telegram-desktop
    omnix
    google-chrome
  ];

  linux = lib.optionals isLinux (with pkgs;[
    zulip
    nitch
    mailspring
  ]);
  darwin = lib.optionals isDarwin (with pkgs;[
    mas
    raycast
    keycastr
    whatsapp-for-mac
    ice-bar
    utm
  ]);

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
