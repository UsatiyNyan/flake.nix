{
  buildInputs = {pkgs-unstable, ...}:
    with pkgs-unstable; [
      zig
    ];
  nixvim = {pkgs-unstable, ...}: {
    plugins.lsp.servers.zls = {
      enable = true;
      package = pkgs-unstable.zls;
    };
  };
}
