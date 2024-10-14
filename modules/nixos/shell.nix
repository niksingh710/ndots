{ pkgs, ... }: {
  config = {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
  };
}
