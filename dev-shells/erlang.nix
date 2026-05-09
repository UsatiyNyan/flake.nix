{
  buildInputs = {
    pkgs,
    pkgs-unstable,
    ...
  }:
    (with pkgs; [
      erlang
      elixir
      beamPackages.rebar3
      inotify-tools
    ])
    ++ (with pkgs-unstable; [
      gleam
    ]);
  nixvim = {pkgs-unstable, ...}: {
    plugins = {
      lsp.servers = {
        elp.enable = true;
        elixirls.enable = true;
        gleam = {
          enable = true;
          package = pkgs-unstable.gleam;
        };
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
