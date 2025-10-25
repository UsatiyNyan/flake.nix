{inputs, pkgs, config, ...}: {
  home.packages = [
    (pkgs.writeScriptBin
      "my-dev-shell"
      ''
        #!/bin/sh
        nix develop ${inputs.self}#$1 --command $SHELL
      '')
  ];

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
      # Modify prompt
      if [[ $TERM = (*256color|*rxvt*) ]]; then
        my_nix_blue="%{''${(%):-"%F{117}"}%}"   # light-blue, Nix flake style
      else
        my_nix_blue="%{''${(%):-"%F{blue}"}%}"  # fallback
      fi
      function devshell_prompt_info {
        if [[ -n "''${MY_NIX_VIA}" ]]; then
          echo "''${my_nix_blue}$MY_NIX_VIA   %{$reset_color%}";
        fi
      }
      PROMPT="$PROMPT\$(devshell_prompt_info)"

      # Match results that include your partial input anywhere within the completion candidates.
      zstyle ':completion:*' matcher-list 'm:{a-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

      eval "$(zoxide init zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      theme = "half-life";
      custom = "${config.xdg.configHome}/oh-my-zsh";
      plugins = ["git"];
    };
  };
}
