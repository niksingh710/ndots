# General boot configuration to make booting look nice
{ lib, pkgs, ... }:
with lib;
{
  environment.etc."issue".source = pkgs.runCommand "issue" { } # bash
    ''
      echo "Welcome to NixOs!" > $out
    '';
  systemd.watchdog.rebootTime = "0s";
  boot = {
    plymouth.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = !cfg.silent;
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "nowatchdog"
    ];
  };
}
