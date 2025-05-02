{pkgs, ...}: {
  home.packages = with pkgs; [
    clang
    clang-tools
    cmake
    ninja
    vscode-extensions.vadimcn.vscode-lldb
  ];

  programs.nixvim.plugins.lsp.servers = {
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
}
