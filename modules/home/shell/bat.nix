{ pkgs, lib, ... }:
{
  programs.bat = {
    enable = true;
  };
  home = {
    shellAliases.cat = "bat --paging=never --style=plain";
    # activation.cache-fix = lib.hm.dag.entryAfter [ "writeBoundary" ] # sh
    #   ''
    #     # Fix for bat cache error
    #     ${lib.getExe pkgs.bat} cache --clear
    #   '';
  };
}
