{ pkgs, ... }:
{
  services = {
    fprintd = {
      enable = true;
    };
    udev.packages = with pkgs.custom;[
      # libfprint-goodixtls-55x4
    ];
  };
  security.pam.services.hyprlock.fprintAuth = true;
  environment.systemPackages = with pkgs.custom; [
    # FIXME: This is notworking as expected (used to work on Arch Linux)
    # libfprint-goodixtls-55x4
  ];
}
