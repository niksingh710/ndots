{ inputs, pkgs, ... }:
let

  minimal-tmux = inputs.minimal-tmux.packages.${pkgs.system}.default;
  vim-edit-tmux-output = pkgs.writeScript "vim-edit-tmux-output" # bash
    ''
      editor="vim"

      file=$(mktemp).txt
      tmux capture-pane -pS -32768 >"$file"
      tmux new-window -n:mywindow "$editor '+ normal G $' $file"
    '';

  unbind = # tmux
    ''
      # Unbind
      unbind C-b
      unbind %
      unbind '"'
      unbind r
      unbind p
      unbind n
      unbind '{'
      unbind '}'
      unbind '['
      unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode when dragging with mouse
    '';

  options = # tmux
    ''
      set -g default-command "''${SHELL}"

      # Default config that will be appended to the end of the generated tmux.conf
      set -g set-clipboard on
      set-option -g automatic-rename on
      set-option -g status-style bg=default

      set-option -ga terminal-overrides ",xterm*:Tc"

      # Enable Sixel support
      set -g allow-passthrough on


      # christoomey Mappings Smart pane switching with awareness of vim and nvim and fzf
      # ik using `vim-tmux-navigator would do this in less line but it  won't allow me to pass the mappings in fzf`
      forward_programs="view|n?vim?|fzf"

      should_forward="ps -o state= -o comm= -t '#{pane_tty}' |\
        grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?($forward_programs)(diff)?$'"


      bind -n C-h if-shell "$should_forward" "send-keys C-h" "select-pane -L"
      bind -n C-j if-shell "$should_forward" "send-keys C-j" "select-pane -D"
      bind -n C-k if-shell "$should_forward" "send-keys C-k" "select-pane -U"
      bind -n C-l if-shell "$should_forward" "send-keys C-l" "select-pane -R"
      bind -n C-\\ if-shell "$should_forward" "send-keys C-\\" "select-pane -l"

      # Undercurl
      set -g default-terminal "''${TERM}"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
      set -s extended-keys on
      set -as terminal-features 'xterm*:extkeys'
    '';

in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "screen-256color";
    aggressiveResize = true;

    plugins = (with pkgs.tmuxPlugins; [ open urlview ])
      ++ [{ plugin = minimal-tmux; }];

    extraConfig = # tmux
      ''
            ${options}
            ${unbind}

            # Setting up preferred keybindings

            set -g prefix C-a                                 # change prefix to Control-a

        bind C-a send-prefix
            # Mapping in bind are to be followed by leader key -> `C-a` <bind>
            bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded."
            bind n new-window
            bind N new-session

            bind H swap-pane -D
            bind L swap-pane -U

            bind C-e run-shell "${vim-edit-tmux-output}"    # edit tmux output in vim `ctrl-e`

            # window remap `-r` allows to repeat the keybinding
            bind -r C-h previous-window
            bind -r C-l next-window

            bind -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
            bind -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"
            bind -T copy-mode-vi 'C-v' send -X rectangle-toggle

            bind -T copy-mode-vi v send -X begin-selection
            bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel
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

            set -g @urlview-key 'u'
      '';

  };
}
