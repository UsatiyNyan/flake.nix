{
  pkgs,
  my,
  ...
} @ args: {
  buildInputs = with pkgs; [
    ghc
    cabal-install
    haskell-language-server
    (import my.modules.ide.nixvim-standalone (args
      // {
        additionalComponents = [
          ({...}: {
            plugins.lsp.servers.hls = {
              enable = true;
              installGhc = false;
            };
          })
        ];
      }))
  ];
}
