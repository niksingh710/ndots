{ lib, opts, config, ... }:
with lib;
let cfg = config.nmod.network;
in {
  options.nmod.network = {

    firewall = mkEnableOption "firewall";
    ssh = mkEnableOption "ssh";

    timezone = mkOption {
      type = types.str;
      default = "UTC";
    };
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
    };

  };

  config = mkMerge [
    {
      time.timeZone = mkDefault cfg.timezone;
      i18n.defaultLocale = mkDefault cfg.locale;
      networking = {
        inherit (opts) hostName;
        networkmanager.enable = true;
      };
      users.users.${opts.username}.extraGroups = [ "networkmanager" ];
    }
    (mkIf cfg.firewall { networking.firewall.enable = true; })
    (mkIf cfg.ssh { services.sshd.enable = true; })
  ];
}
