let
  ports = {
    from = 1714;
    to = 1764;
  };
in {
  hm.persist.dir = [ ".config/kdeconnect" ".config/kde.org" ];
  networking.firewall = {
    allowedTCPPortRanges = [ ports ];
    allowedUDPPortRanges = [ ports ];
  };
  hm.services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
