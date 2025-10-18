{pkgs, my, ...} @ args: {
  buildInputs = with pkgs; [
    alejandra
    (import my.modules.ide.nixvim-standalone (args
      // {
        additionalComponents = [
          ({...}: {
            plugins.lsp.servers.nixd = {
              enable = true;
              onAttach.function = ''
              nmap('<leader>cf', '<cmd>silent !alejandra %<CR>', 'Nixd: alejandra: format')
              '';
            };
          })
        ];
      }))
  ];
}
