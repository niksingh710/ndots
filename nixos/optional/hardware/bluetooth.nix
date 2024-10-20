{ pkgs, ... }: {
  persist.dir = [
    "/var/lib/bluetooth"
  ];
  hardware.bluetooth = {
    enable = true;
    package = pkgs.stable.bluez;
    powerOnBoot = true;
  };

  # https://github.com/NixOS/nixpkgs/issues/114222
  systemd.user.services.telephony_client.enable = false;
}
