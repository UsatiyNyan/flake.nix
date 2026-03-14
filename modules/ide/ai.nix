{pkgs, ...}: {
  home = {
    packages = with pkgs; [aider-chat claude-code];
    file = {
      ".local/.gitignore".text = ''
        .aider*
      '';
    };
  };
}
