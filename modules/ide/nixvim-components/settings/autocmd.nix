{
  lib,
  my,
  ...
}: let
  helpers = my.lib.nixvim lib;
  mkRaw = helpers.mkRaw;
in {
  autoCmd = [
    {
      group = "YankHighlight";
      event = "TextYankPost";
      pattern = "*";
      callback = mkRaw "function() vim.highlight.on_yank() end";
    }
    {
      event = ["BufRead" "BufNewFile"];
      pattern = ["*.vert" "*.frag"];
      command = "set filetype=glsl";
    }
    {
      event = ["FileType"];
      pattern = ["nix"];
      command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2";
    }
  ];
  autoGroups = {
    YankHighlight.clear = true;
  };
}
