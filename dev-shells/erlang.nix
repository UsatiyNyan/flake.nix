{
  buildInputs = {
    inputs,
    system,
    pkgs,
    ...
  }:
    (with pkgs; [
      erlang
      elixir
      beamPackages.rebar3
      inotify-tools
    ])
    ++ (with inputs.nixpkgs-unstable.legacyPackages.${system}; [
      gleam
    ]);
  nixvim = {...}: {
    plugins = {
      lsp.servers = {
        elp.enable = true;
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
