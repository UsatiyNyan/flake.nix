{pkgs, ...}: {
  home.packages = with pkgs; [
    clang
    clang-tools
    cmake
    extra-cmake-modules
    ninja
    vscode-extensions.vadimcn.vscode-lldb
  ];

  home.file = {
    ".local/bin/cmake-build" = {
      source = ./scripts/cmake-build.sh;
      executable = true;
    };
    ".local/bin/cmake-generate" = {
      source = ./scripts/cmake-generate.sh;
      executable = true;
    };
    ".local/.gitignore".text = ''
      __cmake_systeminformation/
    '';
  };

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
