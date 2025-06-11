{pkgs, ...}: {
  programs.nixvim.plugins.lsp.servers.nixd = {
    enable = true;
    onAttach.function = ''
      nmap('<leader>cf', '<cmd>silent !alejandra %<CR>', 'Nixd: alejandra: format')
    '';
  };
  home.packages = with pkgs; [alejandra];
}
