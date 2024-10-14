{
  boot.supportedFilesystems = [ "btrfs" "vfat" ];

  services.btrfs = {
    autoScrub = {
      interval = "weekly";
      enable = true;
    };
  };
}
