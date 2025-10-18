{pkgs, my, ...} @ args: {
  buildInputs = with pkgs; [
    typescript-language-server
    (import my.modules.ide.nixvim-standalone (args
      // {
        additionalComponents = [
          ({...}: {
            plugins.lsp.servers.ts_ls.enable = true;
          })
        ];
      }))
  ];
}
