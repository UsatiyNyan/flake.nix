{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: rustup - is not "declarative"
    rust-analyzer
    rustc
    cargo

    clippy
    rustfmt
  ];

  programs.nixvim = {
    plugins.lsp.servers.rust_analyzer = {
      enable = true;
      installCargo = false;
      installRustc = false;
    };

    extraPlugins = with pkgs.vimPlugins; [
      rust-tools-nvim
    ];
  };
}
