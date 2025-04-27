{ opts, pkgs, ... }:
{
  # TODO: Create a new repo with a set of modules having android building and basic usage setup

  environment.systemPackages = with pkgs; [
    android-tools
    scrcpy
    android-file-transfer
  ];
  users.users.${opts.username}.extraGroups = [ "plugdev" ];
  services.udev.packages = [ pkgs.android-udev-rules ];
}
