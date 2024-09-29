{ inputs, lib, ... }:
with lib; {
  options.nmod.disks = {
    impermanence = mkEnableOption "impermanence";
    encrypted = mkEnableOption "encrypted";
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
