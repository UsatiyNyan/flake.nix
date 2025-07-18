{config, ...}: {
  # home.file.".config/oh-my-zsh/themes/ultima.zsh-theme".source = inputs.omz-ultima-theme + /ultima.zsh-theme;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initContent = ''
      # Match results that include your partial input anywhere within the completion candidates.
      zstyle ':completion:*' matcher-list 'm:{a-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

      eval "$(zoxide init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      # theme = "ultima";
      theme = "half-life";
      custom = "${config.xdg.configHome}/oh-my-zsh";
      plugins = ["git"];
    };
  };
}
