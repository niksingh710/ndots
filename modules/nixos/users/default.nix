{ opts, config, lib, pkgs, ... }: with lib;
let
  cfg = config.ndots.users;
  inherit (opts) username;
in
{
  # In future this file should expose options to quickly add multiple users in the session

  options.ndots.users.password = mkOption {
    type = types.str;
    default = "nixos";
    description = "Password for the user";
  };

  config = {
    programs.zsh.enable = true;
    users = {
      defaultUserShell = pkgs.zsh;
      groups."${username}" = { }; # Creates a default group with the username
      users."${username}" = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "${username}" ];
        useDefaultShell = true;
        password = "${cfg.password}";
      };
    };
  };
}
