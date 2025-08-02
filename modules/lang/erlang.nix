{pkgs, ...}: {
  home.packages = with pkgs; [
    erlang
    elixir
    gleam
    beamPackages.rebar3
    inotify-tools
  ];

  programs.nixvim = {
    plugins = {
      lsp.servers = {
        erlangls.enable = true;
        elixirls.enable = true;
        gleam.enable = true;
      };

      treesitter.settings.ensure_installed = [
        "erlang"
        "elixir"
        "gleam"
      ];
    };

    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["gleam"];
        command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2";
      }
    ];
  };
}
