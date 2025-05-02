{pkgs, ...}: {
  home.packages = with pkgs; [
    ghc
    cabal-install
    haskell-language-server
  ];

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
