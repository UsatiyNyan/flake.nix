{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      alejandra
    ];
  nixvim = {...}: {
    plugins = {
      lsp.servers.nixd = {
        enable = true;
        onAttach.function = ''
          nmap('<leader>cf', '<cmd>w<CR><cmd>silent !alejandra %<CR>', 'Nixd: alejandra: format')
        '';
      };
      treesitter.settings.ensure_installed = ["nix"];
    };
    autoCmd = [
      {
        event = "BufWritePost";
        pattern = "*.nix";
        command = "silent !alejandra % | checktime";
      }
    ];
  };
}
