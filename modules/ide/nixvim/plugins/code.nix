{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "bash" "nix"
          "c" "cpp" "glsl"
          "lua" "python"
          "javascript" "html"
          "haskell" "ocaml" "rust"
        ];
        sync_install = false;
        highlight.enable = true;
        indent.enable = true;
        auto_install = false;
        ignore_install = [];
      };
    };
  };
}
