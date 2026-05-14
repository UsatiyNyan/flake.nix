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
          outputPath = "$root/$dir/$name";
        };
      };
      typst-preview = {
        enable = true;
        settings = {
          port = 7457;
          dependencies_bin = {
            tinymist = null;
          };
          invert_colors = "auto";
        };
      };
      treesitter.settings.ensure_installed = ["typst"];
    };
  };
}
