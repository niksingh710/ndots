{ pkgs, lib, ... }:
{
  options.nmod.games.lutris.enable = lib.mkEnableOption "Enable Lutris";
  config = {
    environment.systemPackages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          # List package dependencies here
        ];
        extraLibraries = pkgs: [
          # List library dependencies here
        ];
      })
    ];
  };
}
