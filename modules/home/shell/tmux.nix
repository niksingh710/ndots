{ pkgs, inputs,  ... }:
let
  navigator = pkgs.tmuxPlugins.vim-tmux-navigator.overrideAttrs (oa: {
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-tmux-navigator";
      rev = "d847ea942a5bb4d4fab6efebc9f30d787fd96e65";
      hash = "sha256-EkuAlK7RSmyrRk3RKhyuhqKtrrEVJkkuOIPmzLHw2/0=";
    };
  });
in
{
# TODO: SessionX implementation
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "screen-256color";
    escapeTime = 0;
    aggressiveResize = true;
    plugins = with pkgs;[
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.yank
      tmuxPlugins.open
      navigator
      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
      }
    ];
    extraConfig =
      let
        edit-pane = pkgs.writeShellScript "edit-pane" #sh
          ''
            buf=$(mktemp).sh
            # -32768 is the length of the buffer
            # Why -32768? Coz everyone using this
            tmux capture-pane -pS -32768 > "$buf"
            tmux new-window -n:edit-pane "$EDITOR $buf"
          '';
      in
      # tmux
      ''
        set -g default-command "''${SHELL}" # this will avoid loading profile again
        set -g set-clipboard on
        set-option -g automatic-rename on
        set-option -g status-style bg=default

        set-option -ga terminal-overrides ",xterm*:Tc"

        # Enable Sixel support
        set -g allow-passthrough on

        set -g prefix C-a

        bind C-a send-prefix

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

        # start selecting text with "v"
        bind -T copy-mode-vi 'v' send -X begin-selection
        bind -T copy-mode-vi 'C-v' send -X rectangle-toggle

        bind -T copy-mode-vi v send -X begin-selection
        bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel

        bind -n c-f \
          if-shell -F '#{==:#{session_name},scratch}' \
          { detach-client } { display-popup -h 80% -w 90% -E \
          "tmux new-session -A -s scratch"}

        bind b set-option  status

        bind v split-window -h -c "#{pane_current_path}"
        bind s split-window -v -c "#{pane_current_path}"

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
}
