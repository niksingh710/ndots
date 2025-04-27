{
  pkgs,
  opts,
  lib,
  config,
  ...
}:
with lib;
{
  options.ndots.sec.askPass = lib.mkEnableOption "askPass" // {
    default = true;
  };
  config = {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    environment = {
      variables = {
        GNUPGHOME = "/home/${opts.username}/.gnupg";
        XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory
      };
      systemPackages = with pkgs; [
        libsecret
      ];
    };

    services.gnome.gnome-keyring.enable = true;
    security = {
      pam.services.login.enableGnomeKeyring = true;

      sudo = {
        extraConfig = "Defaults passwd_tries=10";
        wheelNeedsPassword = config.ndots.sec.askPass;
      };
    };
  };
  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}
