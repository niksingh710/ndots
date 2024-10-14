{ modulesPath, lib, config, opts, ... }: {

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot = {
    kernelParams = [
      "amdgpu.runpm=0"
      "amdgpu.ppfeaturemask=0xffffffff"
      "usbcore.autosuspend=15"
    ];

    # This is imp as the drive is encrypted.
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" ];
  };

  # Mounting external HDD to /mnt/hdd
  fileSystems."/run/media/${opts.username}/hdd" = {
    device = "/dev/disk/by-label/HDD";
    fsType = "ext4";
    # `nofail` is imp to prevent boot failure if the drive is not connected.
    options = [ "defaults" "nofail" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

}
