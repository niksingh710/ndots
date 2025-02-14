{ pkgs, opts, ... }: {
  environment.systemPackages = with pkgs; [
    rquickshare
  ];

  networking.firewall = {
    allowedTCPPortRanges = [{
      from = 2002;
      to = 2002;
    }];
    allowedUDPPortRanges = [{
      from = 2002;
      to = 2002;
    }];
  };

  hm.home.file.".local/share/dev.mandre.rquickshare/.settings.json".text = #json
    ''
      {
        "startminimized": false,
        "download_path": "/home/${opts.username}/Downloads/quickshare",
        "autostart": false,
        "visibility": 0,
        "realclose": true,
        "port": 2002
      }
    '';
}
