{pkgs, ...}: {
  home = {
    packages = with pkgs; [aider-chat];
    file = {
      ".local/.gitignore".text = ''
        .aider*
      '';
    };
  };
}
