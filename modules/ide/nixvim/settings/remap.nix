{config, ...}: let
  helpers = config.lib.nixvim;
  mkRaw = helpers.mkRaw;
in {
  programs.nixvim.keymaps = [
    # Diagnostic
    {
      mode = "n";
      key = "[d";
      action = mkRaw "vim.diagnostic.goto_prev";
      options.desc = "Go to previous diagnostic message";
    }
    {
      mode = "n";
      key = "]d";
      action = mkRaw "vim.diagnostic.goto_next";
      options.desc = "Go to next diagnostic message";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = mkRaw "vim.diagnostic.open_float";
      options.desc = "Open floating diagnostic message";
    }
    {
      mode = "n";
      key = "<leader>q";
      action = mkRaw "vim.diagnostic.setloclist";
      options.desc = "Open diagnostics list";
    }

    # Greatest remaps ever: ThePrimeagen
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move selected up";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move selected up";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move selected down";
    }
    {
      mode = "x";
      key = "<leader>p";
      action = ''"_dP'';
      options.desc = "Paste and dont lose the paste-buffer";
    }

    # Greatest remap ever: AsbjornHaland
    {
      mode = ["n" "v"];
      key = "<leader>y";
      action = ''"+y'';
      options.desc = "yank to system clipboard!";
    }
    {
      mode = "n";
      key = "<leader>Y";
      action = ''"+Y'';
      options.desc = "Yank to system clipboard!";
    }
  ];
}
