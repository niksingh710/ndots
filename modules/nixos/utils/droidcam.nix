{ pkgs, opts, ... }:
{

  environment.systemPackages = [
    pkgs.v4l-utils
    pkgs.android-tools
  ];
  services.udev.packages = [ pkgs.android-udev-rules ];
  users.users.${opts.username}.extraGroups = [ "plugdev" ];

  programs.droidcam.enable = true;

  boot = {
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="Droidcam" exclusive_caps=1
    '';
  };
}
