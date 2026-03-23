{ flake, ... }:
{
  home-manager.sharedModules = [
    flake.homeModules.default
    flake.homeModules.packages
    flake.homeModules.terminal
    flake.homeModules.mpv
    flake.homeModules.zathura

    flake.homeModules.browser
    flake.homeModules.hyprland
  ];
}
