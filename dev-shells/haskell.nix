{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      ghc
      cabal-install
      haskell-language-server
    ];
  nixvim = {...}: {
    plugins = {
      lsp.servers.hls = {
        enable = true;
        installGhc = false;
      };
      treesitter.settings.ensure_installed = ["haskell"];
    };
  };
}
