{ flake, ... }:
{
  # These modules will be shared between all the users.
  # Basically ui based stuff, darwin things those are nix-darwin independent.
  # a normal user setup that is on darwin can also use this.
  home-manager.sharedModules = [
    flake.homeModules.default
    flake.homeModules.packages
    flake.homeModules.terminal
    flake.homeModules.mpv
    flake.homeModules.zathura

    flake.homeModules.browser
  ];
}
