{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  hardware = {
    cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;

    graphics = {
      enable = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
      ];
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
      ];
    };
  };
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
}
