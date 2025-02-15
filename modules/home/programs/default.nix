{ pkgs, ... }:
{
  home.packages = with pkgs;[
    materialgram
    webcord-vencord
  ];
}
