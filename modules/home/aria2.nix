{ pkgs, ... }:
{
  programs.aria2 = {
    enable = true;
    settings = {
      file-allocation = "falloc";
      systemd = pkgs.stdenv.isLinux;
      continue = true;
      max-concurrent-downloads = 20;
      max-connection-per-server = 10;
      split = 4;
      min-split-size = "10M";
    };
  };
}
