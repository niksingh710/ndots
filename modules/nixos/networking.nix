{ lib, opts, config, pkgs, ... }:
with lib;
let cfg = config.nmod.network;
in {
  options.nmod.network = {

    firewall = mkEnableOption "firewall";
    stevenblack = mkEnableOption "stevenblack";

    timezone = mkOption {
      type = types.str;
      default = "UTC";
    };
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
    };

  };

  config = {
    environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
    time.timeZone = mkDefault cfg.timezone;
    i18n.defaultLocale = mkDefault cfg.locale;
    networking = {
      firewall.enable = cfg.firewall;
      stevenblack.enable = cfg.stevenblack;
      inherit (opts) hostName;
      networkmanager.enable = true;
    };
    users.users.${opts.username}.extraGroups = [ "networkmanager" ];
  };
}
