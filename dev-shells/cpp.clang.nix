{
  pkgs,
  my,
  ...
} @ args: {
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
    pkgs.writeShellApplication
    {
      name = "cmake-build";
      text = builtins.readFile ./cpp.scripts/cmake-build.sh;
    }
    pkgs.writeShellApplication
    {
      name = "cmake-generate";
      text = builtins.readFile ./cpp.scripts/cmake-generate.sh;
    }
  ];
}
