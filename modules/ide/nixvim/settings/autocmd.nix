{ config, ... }:
let
  helpers = config.lib.nixvim;
  mkRaw = helpers.mkRaw;
in
{
  programs.nixvim = {
    autoCmd = [
      {
        group = "YankHighlight";
        event = "TextYankPost";
        pattern = "*";
        callback = mkRaw "vim.highlight.on_yank";
      }
      {
        event = [ "BufRead" "BufNewFile" ];
        pattern = [ "*.vert" "*.frag" ];
        command = "set filetype=glsl";
      }
    ];
    autoGroups = {
      YankHighlight.clear = true;
    };
  };
}
