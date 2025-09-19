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

    # FIXME: Get sine build with the package to make it use with nebula
    # TRACK: if <https://github.com/CosmoCreeper/Sine/issues/274> this get's fixed
    # Then override fix can work with it's.
    flake.homeModules.browser

    flake.inputs.mac-app-util.homeManagerModules.default
  ];
}
