{ modulesPath, lib, config, flake, pkgs, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  powerManagement.cpuFreqGovernor = "performance";
  boot = {
    kernelParams = [
      "amdgpu.runpm=0"
      "amdgpu.ppfeaturemask=0xffffffff"
      "usbcore.autosuspend=-1"
      "amdgpu"
    ];
    extraModprobeConfig = "options i915 enable_guc=2";

    # This is imp as the drive is encrypted.
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
    kernelModules = [ "kvm-intel" ];
  };

  # Mounting external HDD to /mnt/hdd
  fileSystems."/run/media/${flake.config.me.username}/hdd" = {
    device = "/dev/disk/by-label/HDD";
    fsType = "ext4";
    # `nofail` will prevent boot failure if the drive is not connected.
    options = [
      "defaults"
      "nofail"
    ];
  };
  services.thermald.enable = true;
  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    graphics = {
      enable = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        intel-vaapi-driver
      ];
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
      ];
    };
  };
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD"; # Force intel-media-driver
}
