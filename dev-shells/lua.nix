{pkgs, my, ...} @ args: {
  buildInputs = with pkgs; [
    luajit
    lua-language-server
    (import my.modules.ide.nixvim-standalone (args
      // {
        additionalComponents = [
          ({...}: {
            plugins.lsp.servers.lua_ls = {
              enable = true;
              settings = {
                telemetry.enable = false;
                workspace.checkThirdParty = false;
              };
            };
          })
        ];
      }))
  ];
}
