{ pkgs, opts, ... }: {
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment = {
    variables.GNUPGHOME = "/home/${opts.username}/.gnupg";
    systemPackages = with pkgs; [
      libsecret
    ];
  };

  services.gnome.gnome-keyring.enable = true;
  security = {
    pam.services.login.enableGnomeKeyring = true;
    polkit = {
      enable = true;
      extraConfig = # js
        ''
          polkit.addRule(function(action, subject) {
            if (subject.isInGroup("${opts.username}")) {
              return polkit.Result.YES;
            }
          })
        '';
    };
    sudo = {
      extraConfig = "Defaults passwd_tries=10";
      wheelNeedsPassword = false;
    };
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
