{ pkgs, config, ... }:
let
  # TODO: Add the package to nixpkgs
  # https://github.com/NixOS/nixpkgs/pull/420244
  minimal-tmux-status = (builtins.getFlake
    "github:niksingh710/minimal-tmux-status/de2bb049a743e0f05c08531a0461f7f81da0fc72").packages.${pkgs.system}.default;
  # TODO: Update the package on nixpkgs to a newer version
  navigator = pkgs.tmuxPlugins.vim-tmux-navigator.overrideAttrs (oa: {
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-tmux-navigator";
      rev = "412c474e97468e7934b9c217064025ea7a69e05e";
      hash = "sha256-EkuAlK7RSmyrRk3RKhyuhqKtrrEVJkkuOIPmzLHw2/0=";
    };
  });
  edit-pane = pkgs.writeShellScript "edit-pane" # sh
    ''
      buf=$(mktemp).sh
      # -32768 is the length of the buffer
      # Why -32768? Coz everyone using this
      tmux capture-pane -pS -32768 > "$buf"
      tmux new-window -n:edit-pane "$EDITOR $buf"
    '';
  # on vm with only home-manager config kitty might throw error for EGL
  xterm = if config.programs.kitty.enable then "xterm-kitty" else "xterm-256color";
in
{
  programs = {
    # TODO: Test tmate vs upterm
    # tmate.enable = true;
    tmux = {
      enable = true;
      baseIndex = 1;
      keyMode = "vi";
      mouse = true;
      shortcut = "a";
      escapeTime = 0;
      secureSocket = false;
      plugins = [
        navigator
        {
          plugin = minimal-tmux-status;
          extraConfig = ''
            set -g @minimal-tmux-use-arrow true
            set -g @minimal-tmux-right-arrow ""
            set -g @minimal-tmux-left-arrow ""
          '';
        }
        pkgs.tmuxPlugins.better-mouse-mode
        pkgs.tmuxPlugins.yank
        pkgs.tmuxPlugins.open
        pkgs.tmuxPlugins.fzf-tmux-url
      ];
      extraConfig = # tmux
        ''
          # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
          set -g default-terminal ${xterm}
          set -g allow-passthrough on
          set -ga terminal-overrides ",*256col*:Tc"
          set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'

          set-environment -g COLORTERM "truecolor"

          set-option -ga update-environment " UPTERM_ADMIN_SOCKET"
          set-option -ga update-environment "SSH_AUTH_SOCK"

          set -g set-clipboard on
          set-option -g automatic-rename on
          set-option -g status-style bg=default
          set -g prefix C-a

          bind N new-session
          bind n new-window

          bind H swap-pane -D
          bind L swap-pane -U

          # edit tmux output in vim `ctrl e`
          bind C-e run-shell "${edit-pane}"

          bind-key r movew -r\; display-message "Renumbered Windows"

          # window remap `-r` allows to repeat the keyb
          bind -r C-h previous-window
          bind -r C-l next-window

          bind-key x kill-pane # skip "kill-pane 1? (y/n)" prompt
          set -g detach-on-destroy off  # don't exit from tmux when closing a session

          # start selecting text with "v"
          bind -T copy-mode-vi 'v' send -X begin-selection
          bind -T copy-mode-vi 'C-v' send -X rectangle-toggle

          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel

          bind b set-option  status

          bind v split-window -h -c "#{pane_current_path}"
          bind s split-window -v -c "#{pane_current_path}"

          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"

          bind S choose-session

          bind -r j resize-pane -D
          bind -r k resize-pane -U
          bind -r l resize-pane -R
          bind -r h resize-pane -L
          bind -r m resize-pane -Z

          bind x kill-pane
          bind q kill-window
          bind Q kill-session

          bind V copy-mode
        '';
    };
  };
  home.shellAliases.ta = "tmux -u new-session -A -s";
}
