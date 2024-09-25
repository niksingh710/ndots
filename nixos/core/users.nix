{ opts, lib, config, ... }:
with lib;
let inherit (config.core) sops;
in {

  sops.secrets.user-password.neededForUsers = sops;
  users = {
    groups."${opts.username}" = { };
    users.${opts.username} = mkMerge [
      {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "${opts.username}" ];
        useDefaultShell = true;
      }
      (if sops then {
        hashedPasswordFile = config.sops.secrets.user-password.path;
      } else {
        initialPassword = "${opts.password}";
      })
    ];
  };
}
