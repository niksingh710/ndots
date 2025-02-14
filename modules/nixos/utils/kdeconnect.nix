{ lib, ... }:
let
  ports = {
    from = 1714;
    to = 1764;
  };
in
{
  networking.firewall = {
    allowedTCPPortRanges = [ ports ];
    allowedUDPPortRanges = [ ports ];
  };
  hm.systemd.user.services = {
    kdeconnect.Unit.After = lib.mkForce [ "graphical-session.target" ];
    kdeconnect-indicator.Unit.After = lib.mkForce [ "graphical-session.target" ];
  };
  hm.services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
