{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      # TODO: rustup - is not "declarative"
      rust-analyzer
      rustc
      cargo
      clippy
      rustfmt
    ];
  nixvim = {...}: {
    plugins = {
      lsp.servers.rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
      treesitter.settings.ensure_installed = ["rust"];
    };
  };
  shellHook = ''
    export PATH="$PATH:$HOME/.cargo/bin/"
  '';
}
