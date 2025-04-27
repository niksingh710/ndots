{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  configDir = "${config.hm.home.homeDirectory}/.config/rclone";
  configPath = "${configDir}/rclone.conf";
  args = [
    "--daemon"
    "--vfs-cache-mode full"
    "--vfs-cache-max-size 10G"
    "--vfs-cache-max-age 1h"
    "--buffer-size 32M"
    "--dir-cache-time 12h"
    "--poll-interval 1m"
    "--attr-timeout 1s"
    "--async-read"
  ];
in
{
  hm.sops.secrets."rclone/conf".path = "${configPath}";
  hm.sops.secrets."rclone/locked-conf".path = "${configDir}/rclone-locked.conf";
  hm.home = {
    packages = with pkgs; [ rclone ];
    shellAliases = rec {
      rmount = "${getExe pkgs.rclone} mount ${builtins.concatStringsSep " " args}";
      rmount-locked = "RCLONE_CONFIG=$HOME/.config/rclone/rclone-locked.conf \
              ${getExe pkgs.rclone} mount ${builtins.concatStringsSep " " args}";

      rdrive = "mkdir -p $HOME/drive/gdrive; ${rmount} gdrive: $HOME/drive/gdrive";
    };
  };
}
