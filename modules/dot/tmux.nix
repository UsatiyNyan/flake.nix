{
  pkgs,
  user,
  ...
}: {
  home.packages = [
    (pkgs.writeScriptBin
      "my-tmux-attach"
      ''
        #!/bin/sh
        if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
            tmux attach-session -t ${user} || tmux new-session -s ${user}
        fi
      '')
    (pkgs.writeScriptBin
      "my-tmux-new"
      ''
        #!/bin/sh
        if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
            tmux new-session -t ${user}
        fi
      '')
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    prefix = "C-space";
    sensibleOnTop = true;
    extraConfig = ''
      # term colors
      set -as terminal-features ",alacritty*:RGB"

      # Shift Alt H/L to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # split windows in current path
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # rotate panes
      bind r swap-pane -D
      bind R swap-pane -U

      # enable transparency
      set -g status-style 'bg=default'
      set -g window-style 'bg=default'
      set -g window-active-style 'bg=default'
      set -g window-status-style 'bg=default'
      set -g window-status-current-style 'bg=default'
    '';

    # https://github.com/NixOS/nixpkgs/blob/nixos-24.11/pkgs/misc/tmux-plugins/default.nix
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main' # Options are 'main', 'moon' or 'dawn'
          set -g @rose_pine_bar_bg_disable 'on'
        '';
      }
      yank
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        '';
      }
    ];
  };
}
