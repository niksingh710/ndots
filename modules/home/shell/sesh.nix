{ pkgs, lib, ... }:
{
  programs.fzf.tmux.enableShellIntegration = true;
  programs.sesh = {
    enable = true;
    tmuxKey = "c-o";
    settings = {
      blacklist = [ "scratch" ];
      session = [
        rec {
          name = "todo";
          path = "~/.todo.md";
          startup_command = "nvim ~/.todo.md";
          preview_command = "${lib.getExe pkgs.glow} ${path}";
        }
      ];
    };
  };
  programs.tmux.extraConfig = # tmux
    ''
      bind -N "last-session (via sesh) " "C-p" run-shell "sesh last"
      bind-key "c-r" display-popup -E -w 40% "sesh connect \"$(
        sesh list -i -H | gum filter --value \"$(sesh root)\" --limit 1 --fuzzy --no-sort --placeholder 'Pick a sesh' --prompt='⚡'readme
      )\""
    '';
}
