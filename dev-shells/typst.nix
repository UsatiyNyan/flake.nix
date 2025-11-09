{
  buildInputs = {pkgs, ...}: [
    pkgs.typst
  ];
  nixvim = {...}: {
    plugins = {
      lsp.servers.tinymist = {
        enable = true;
        settings = {
          formatterMode = "typstfmt";
        };
      };
      treesitter = {
        settings = {
          ensure_installed = ["typst"];
        };
      };
    };
  };
}
