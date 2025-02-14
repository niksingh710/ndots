{ pkgs, lib, opts, config, ... }:
{
  security.polkit = {
    enable = true;
    # Disables password prompt for users in the group
    extraConfig = lib.optionalString (!config.ndots.sec.askPass)
      # js
      ''
        polkit.addRule(function(action, subject) {
          if (subject.isInGroup("${opts.username}")) {
            return polkit.Result.YES;
          }
        })
      '';
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description =
      " This service will ensure that polkit-gnome-authentication-agent-1 is running. pkexec is recommended to be used instead of sudo.";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

}
