{ pkgs, ... }: {
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    wireplumber = {
      enable = true;
      extraConfig."10-disable-camera"."wireplumber.profiles".main."monitor.libcamera" =
        "disabled";
    };
  };

  environment.systemPackages = with pkgs; [ pavucontrol ];
}
