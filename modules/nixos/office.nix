{ pkgs, ... }:
{
  # enabled for office CPU
  services.postgresql = {
    enable = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all     trust


      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host  all      all     ::1/128        trust
    '';
  };
  services.redis.servers.redis = {
    enable = true;
    port = 6379;
  };
}
