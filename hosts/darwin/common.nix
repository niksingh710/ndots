{ pkgs, ... }:
{
  system.stateVersion = 6;
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true;
  };
  system.defaults = {
    dock.autohide = true;
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleICUForce24HourTime = true;
      KeyRepeat = 2;
    };
  };
}
