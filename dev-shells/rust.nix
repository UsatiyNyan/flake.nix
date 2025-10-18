{
  pkgs,
  my,
  ...
} @ args: {
  buildInputs = with pkgs; [
    # TODO: rustup - is not "declarative"
    rust-analyzer
    rustc
    cargo
    wasm-pack
    lld # needed for wasm-pack dylib
    clippy
    rustfmt
    (import my.modules.ide.nixvim-standalone (args
      // {
        additionalComponents = [
          ({...}: {
            plugins.lsp.servers.rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };

            extraPlugins = with pkgs.vimPlugins; [
              rust-tools-nvim
            ];
          })
        ];
      }))
  ];
}
