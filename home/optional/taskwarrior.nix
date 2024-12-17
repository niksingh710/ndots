{ pkgs, ... }: {
  persist = {
    dir = [ ".local/share/task" ".config/syncall" ];
    files = [ ".gtasks_credentials.pickle" ];
  };
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };
  home = {
    shellAliases = {
      gt = "task +gtasks";
      gts = "tw_gtasks_sync -l 'My Tasks' -t gtasks";
    };
    packages = with pkgs;[
      custom.syncall
    ];
  };
}
