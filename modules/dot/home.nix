{
  pkgs,
  user,
  my,
  ...
}: let
  xdgBinPath = "$HOME/.local/bin";
in {
  imports = with my.modules; [
    dot.zsh
    dot.tmux
  ];

  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.05"; # Please read the comment before changing.

    # Home Manager needs a bit of information about you and the paths it should manage.
    username = user;
    homeDirectory = "/home/${user}";

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      # TERMINAL
      wget
      git
      vim
      zoxide
      btop
      ripgrep
      fzf
      tldr
      fd

      # TUI
      bluetuith
    ];

    file = {
      ".local/.gitignore".text = ''
        /build
        __cmake_systeminformation/
      '';
    };

    sessionPath = [xdgBinPath];
    sessionVariables = {
      XDG_BIN_HOME = xdgBinPath;
      XDG_PICTURES_DIR = "$HOME/Pictures";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
