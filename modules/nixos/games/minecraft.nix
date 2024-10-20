{ self, pkgs, lib, config, ... }: with lib;{
  options.nmod.games.minecraft.enable = mkEnableOption "Enable Minecraft";
  config = mkIf config.nmod.games.minecraft.enable {
    environment.systemPackages = [
      (pkgs.callPackage "${self}/pkgs/minecraft" { })
    ];
  };
}
