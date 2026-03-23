{ config, ... }:
# For a new System Copy the generated cert and key and set it in that host's user.
{
  services.syncthing = {
    enable = true;
    guiAddress = "0.0.0.0:8384";
    overrideDevices = false;
    overrideFolders = false;
    settings = {
      gui = {
        theme = "black";
      };

      folders = {
        # <https://nix-community.github.io/home-manager/options.xhtml#opt-services.syncthing.settings.folders._name_.path>
        # as mentioned above `~` will be resolved
        "~/.notes" = rec {
          id = "notes";
          name = id;
          devices = [ "mach" ];
        };
      };
    };
  };
}
