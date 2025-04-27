{
  lib,
  opts,
  config,
  ...
}:
{
  options.ndots.networking.ssh = lib.mkEnableOption "ssh";
  config = {
    services.openssh = {
      enable = config.ndots.networking.ssh;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
    };

    users.users."${opts.username}".openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwouW1kRGVOgb58dJPwF+HCsXXYl2OUOqpxuqAXGKIZ nik.singh710@gmail.com"
    ];
  };
}
