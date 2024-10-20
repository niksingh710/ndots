{ pkgs, lib, ... }:
{
  options.nmod.games.steam.enable = lib.mkEnableOption "Enable Steam";
  config = {
    nmod.games.mangohud.enable = true;
    programs = {
      gamemode.enable = true;
      gamescope = {
        enable = true;
      };
      steam = {
        package = pkgs.steam;
        enable = true;
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
    };
  };
}
