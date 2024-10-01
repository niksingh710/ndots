{ opts, lib, config, ... }:
with lib; {
  sops.secrets =
    mkIf config.nmod.sops.enable { user-password.neededForUsers = true; };
  users = {
    groups."${opts.username}" = { };
    users.${opts.username} = mkMerge [
      {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "${opts.username}" ];
        useDefaultShell = true;
      }
      (if config.nmod.sops.enable then {
        hashedPasswordFile = config.sops.secrets.user-password.path;
      } else {
        initialPassword = "${opts.password}";
      })
    ];
  };
}
