{
  buildInputs = {pkgs, ...}:
    with pkgs; [
      luajit
      lua-language-server
    ];
  nixvim = {...}: {
    plugins.lsp.servers.lua_ls = {
      enable = true;
      settings = {
        telemetry.enable = false;
        workspace.checkThirdParty = false;
      };
    };
  };
}
