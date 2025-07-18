{ flake, lib, ... }:
let
  inherit (flake) inputs;
in
{
  imports = [ inputs.disko.nixosModules.disko ];
  options = {
    ndots.disko = {

      encrypted = {
        enable = lib.mkEnableOption "Disk is Encrypted";
        name = lib.mkOption (with lib ;{
          type = types.str;
          default = "cryptroot";
          description = "Options for ssd disk";
        });
      };
      impermanence = lib.mkEnableOption "Impermanent setup";

      ssd = {
        enable = lib.mkEnableOption "Disk is SSD";
        options = lib.mkOption (with lib ;{
          type = types.listOf types.str;
          default = [
            "ssd"
            "discard=async"
            "noatime"
            "compress=zstd"
          ];
          description = "Options for ssd disk";
        });
      };
    };
  };
}
