{ pkgs, ... }:
{
  hm.home.packages = with pkgs; [
    google-chrome
    wget
  ];
}
