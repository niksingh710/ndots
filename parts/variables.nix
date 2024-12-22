{ lib, ... }:
with lib; {
  flake = {
    options = {
      opts = {
        username = mkOption {
          type = types.str;
          default = "niksingh710";
          description =
            "The main username to be used throughout the configuration";
        };
        mail = mkOption {
          type = types.str;
          default = "nik.singh710@gmail.com";
          description =
            "The main username to be used throughout the configuration";
        };

        transparency = mkEnableOption "transparency" // { default = true; };

        password = mkOption {
          type = types.str;
          default = "password";
          description = "String to hold initial password for the user";
        };
        wallpapaer = mkOption {
          type = types.path;
          description = "Path to the image for wallpaper";
        };
      };
    };
  };
}
