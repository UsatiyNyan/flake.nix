{pkgs, ...}: {
  buildInputs = with pkgs; [
    ghc
    cabal-install
    haskell-language-server
  ];
}
