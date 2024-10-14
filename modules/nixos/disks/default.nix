{ lib, ... }:
with lib; {
  options.nmod.disks = {
    impermanence = mkEnableOption "impermanence";
    encrypted = {
      enable = mkEnableOption "encrypted";
      name = mkOption {
        type = types.str;
        example = literalExample "cryptroot";
        default = "cryptroot";
        description = ''
          The name of the encrypted partition.
        '';
      };
    };
    partition = mkOption {
      type = types.str;
      example = literalExample "/dev/vda";
      default = "/dev/nvme0n1";
      description = ''
        The partition to format to be passed in disko.
      '';
    };
  };

  imports = [
    ./impermanence.nix
    ./disko.nix

    ./btrfs.nix
    ./ssd.nix
  ];
}
