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
      pkgs.stable.telegram-desktop
      zoom-us
      upterm
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
  programs.zsh.initContent = # sh
    ''
      if command -v upterm > /dev/null; then
        source <(upterm completion zsh)
      fi
    '';
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
