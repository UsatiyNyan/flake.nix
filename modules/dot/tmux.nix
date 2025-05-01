{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    terminal = "xterm-256color";
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
    '';

    # https://github.com/NixOS/nixpkgs/blob/nixos-24.11/pkgs/misc/tmux-plugins/default.nix
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main' # Options are 'main', 'moon' or 'dawn'
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
