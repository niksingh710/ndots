{
  lib,
  pkgs,
  config,
  opts,
  ...
}:
with lib;
let
  cfg = config.ndots.networking;
in
{
  options.ndots.networking = {
    firewall = mkEnableOption "firewall";
    stevenblack = mkEnableOption "stevenblack ads block";

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
      networkmanager.enable = true;
      inherit (opts) hostName;
    };
    users.users.${opts.username}.extraGroups = [ "networkmanager" ];
  };

  imports =
    with builtins;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}
