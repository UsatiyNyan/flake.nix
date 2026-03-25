{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      go
    ];
  nixvim = {...}: {
    plugins = {
      lsp.servers = {
        gopls.enable = true;
      };
      treesitter.settings.ensure_installed = [
        "go"
      ];
    };
  };
}
