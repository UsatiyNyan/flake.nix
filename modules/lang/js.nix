{pkgs, ...}: {
  home.packages = with pkgs; [
    typescript-language-server
  ];

  programs.nixvim = {
    plugins.lsp.servers.ts_ls = {
      enable = true;
    };
  };
}
