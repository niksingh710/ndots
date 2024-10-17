{ pkgs, lib, config, ... }: with lib;
let
  cfg = config.hmod;

  rcloneConfig = "${config.home.homeDirectory}/.config/rclone/rclone.conf";

  argsList = [
    "--daemon"
    "--vfs-cache-mode full"
    "--vfs-cache-max-size 10G"
    "--vfs-read-chunk-size 32M"
    "--vfs-read-chunk-size-limit 1G"
    "--dir-cache-time 1h"
    "--buffer-size 16M"
    "--poll-interval 1m"
    "--timeout 10m"
  ];

  drives = [
    "gdrive"
    "gphotos"
  ];

  genScript = drives: ''
    mkdir -p ${config.home.homeDirectory}/drive/{${builtins.concatStringsSep "," drives}}
    ${builtins.concatStringsSep "\n" (map (drive: "${getExe pkgs.rclone} mount ${drive}: ${config.home.homeDirectory}/drive/${drive} ${builtins.concatStringsSep " " argsList} &") drives)}
    ${getExe' pkgs.libnotify "notify-send"} "Rclone mounted"
  '';

  rmount = pkgs.writeScriptBin "rmount" ''
    ${genScript drives}
  '';
  rumount = pkgs.writeScriptBin "rumount" ''
    ${builtins.concatStringsSep "\n" (map (drive: "umount ${config.home.homeDirectory}/drive/${drive}") drives)}
  '';
in
{
  options.hmod.rclone.enable = mkEnableOption "rclone";
  config =
    mkIf (cfg.rclone.enable && cfg.sops.enable) {
      home.packages = [ pkgs.rclone rmount rumount ];
      sops.secrets."rclone/conf".path = "${rcloneConfig}";
    };
}
