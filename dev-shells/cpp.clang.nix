{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      clang
      clang-tools
      cmake
      extra-cmake-modules
      ninja
      vscode-extensions.vadimcn.vscode-lldb
    ];
  nixvim = {...}: {
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
  };
  scripts = {
    name = "cpp.scripts";
    src = ./cpp.scripts;
  };
  shellHook = ''
    export CXX="clang++"
    export CC="clang"
  '';
}
