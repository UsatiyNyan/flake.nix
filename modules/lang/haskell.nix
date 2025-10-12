{pkgs, ...}: {
  programs.nixvim = {
    plugins.lsp.servers.hls = {
      enable = true;
      installGhc = false;
    };

    extraPlugins = with pkgs.vimPlugins; [
      haskell-tools-nvim
    ];
  };
}
