{ pkgs, lib, ... }:
{
  programs.fzf.tmux.enableShellIntegration = true;
  # TODO: <https://github.com/joshmedeski/sesh/pull/357> once this is merged, raise nixpkgs pr
  programs.sesh = {
    enable = true;
    tmuxKey = "c-o";
    settings = {
      blacklist = [ "scratch" ];
      dir_length = 2;
      session = [
        rec {
          name = "todo";
          path = "~/.todo/todo.md";
          startup_command = "nvim ${path}";
          preview_command = "${lib.getExe pkgs.glow} ${path}";
        }
        rec {
          name = "notes";
          path = "~/.notes";
          startup_command = # sh
            ''
              nvim --cmd 'let g:auto_session_enabled = v:false' -c 'cd ~/.notes/' -c 'lua vim.schedule(function() vim.cmd("ObsidianQuickSwitch") end)'
            '';
          preview_command = "${lib.getExe pkgs.fzf-preview} ${path}";
        }
        rec {
          name = "LeetCode";
          path = "~";
          startup_command = # sh
            ''
              nvim --cmd 'let g:auto_session_enabled = v:false' -c 'cd ~' -c 'Leet'
            '';
          preview_command = "${lib.getExe pkgs.fzf-preview} ${path}";
        }
        {
          name = "main";
          path = "~";
        }
      ];
    };
  };
  programs.tmux.extraConfig = # tmux
    ''
      bind -N "last-session (via sesh) " "C-p" run-shell "sesh last"
    '';
}
