{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      typescript-language-server
    ];
  nixvim = {...}: {
    plugins = {
      lsp.servers.ts_ls.enable = true;
      treesitter.settings.ensure_installed = [
        "javascript"
      ];
    };
  };
}
