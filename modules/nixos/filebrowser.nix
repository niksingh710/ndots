{ ... }:
{
  services.filebrowser = {
    enable = true;
    openFirewall = true;
    settings = {
      address = "0.0.0.0";
      port = 4321;
    };
  };
}
