{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      typescript-language-server
      nodejs
    ];
  nixvim = {...}: {
    plugins = {
      lsp.servers = {
        ts_ls.enable = true;
        cssls.enable = true;
        html.enable = true;
      };
      treesitter.settings.ensure_installed = [
        "javascript"
        "css"
        "html"
      ];
    };
  };
}
