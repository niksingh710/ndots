{ pkgs, self, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  hm.imports = [
    self.homeModules.shell
  ];
}
