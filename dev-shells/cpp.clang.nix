{
  pkgs,
  my,
  ...
} @ args: let
  mkScripts = name: src:
    pkgs.stdenv.mkDerivation {
      inherit name src;
      installPhase = ''
        mkdir -p $out/bin
        cp ${src}/* $out/bin/
        chmod +x $out/bin/*
      '';
    };
in {
  buildInputs = with pkgs; [
    clang
    clang-tools
    cmake
    extra-cmake-modules
    ninja
    vscode-extensions.vadimcn.vscode-lldb
    (import my.modules.ide.nixvim-standalone (args
      // {
        additionalComponents = [
          ({...}: {
            plugins.lsp.servers = {
              clangd = {
                enable = true;
                onAttach.function = ''
                  nmap('<leader>sh', '<cmd>ClangdSwitchSourceHeader<CR>', 'Clangd: Switch [S]ource [H]eader')
                '';
                cmd = ["clangd" "--compile-commands-dir=./build"];
              };
              neocmake = {
                enable = true;
                filetypes = ["cmake"];
                cmd = ["neocmakelsp" "--stdio"];
              };
              glsl_analyzer.enable = true;
            };
          })
        ];
      }))
    (mkScripts "cpp.scripts" ./cpp.scripts)
  ];
}
