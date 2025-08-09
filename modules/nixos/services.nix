{ lib, ... }:
{
  services = {
    envfs.enable = true;
    fwupd.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
    openssh = {
      enable = lib.mkDefault false;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
      };
    };
  };
}
