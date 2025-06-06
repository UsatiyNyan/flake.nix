{pkgs, ...}: {
  home.packages = with pkgs; [
    lua-language-server
    luajit
  ];

  programs.nixvim.plugins.lsp.servers = {
    lua_ls = {
      enable = true;
      settings = {
        telemetry.enable = false;
        workspace.checkThirdParty = false;
      };
    };
  };
}
