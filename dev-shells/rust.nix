{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      # TODO: rustup - is not "declarative"
      rust-analyzer
      rustc
      cargo
      wasm-pack
      lld # needed for wasm-pack dylib
      clippy
      rustfmt
    ];
  nixvim = {pkgs, ...}: {
    plugins = {
      lsp.servers.rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      treesitter.settings.ensure_installed = ["rust"];
    };

    extraPlugins = with pkgs.vimPlugins; [
      rust-tools-nvim
    ];
  };
}
