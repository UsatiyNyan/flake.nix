{pkgs, ...}: {
  programs.nixvim.plugins.lsp.servers.nixd = {
    enable = true;
    onAttach.function = ''
      nmap('<leader>cf', '<cmd>!alejandra %<CR>', 'Nixd: alejandra: format')
    '';
  };
  home.packages = with pkgs; [alejandra];
}
