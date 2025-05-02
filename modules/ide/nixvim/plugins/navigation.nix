{config, ...}: let
  helpers = config.lib.nixvim;
  mkRaw = helpers.mkRaw;
  mkFun = x: mkRaw ("function () " + x + " end");
  mkCmd = x: "<cmd>" + x + "<CR>";
in {
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;

      harpoon = {
        enable = true;
        enableTelescope = true;
      };
      telescope.enable = true;

      neo-tree.enable = true;
      oil = {
        enable = true;
        settings = {
          columns = ["icon"];
          keymaps."<C-h>" = false; # conflicts with Tmux
          view_options.show_hidden = true;
        };
      };
    };

    keymaps = [
      # tmux-navigator
      {
        mode = "n";
        key = "<C-h>";
        action = mkCmd "TmuxNavigateLeft";
        options.desc = "Tmux: window left";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = mkCmd "TmuxNavigateDown";
        options.desc = "Tmux: window down";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = mkCmd "TmuxNavigateUp";
        options.desc = "Tmux: window up";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = mkCmd "TmuxNavigateRight";
        options.desc = "Tmux: window right";
      }

      # harpoon
      {
        mode = "n";
        key = "<leader>ha";
        action = mkRaw "require('harpoon.mark').add_file";
        options.desc = "Harpoon: add file";
      }
      {
        mode = "n";
        key = "<leader>hm";
        action = mkRaw "require('harpoon.ui').toggle_quick_menu";
        options.desc = "Harpoon: quick menu";
      }
      {
        mode = "n";
        key = "<leader>h1";
        action = mkFun "require('harpoon.ui').nav_file(1)";
        options.desc = "Harpoon: file 1";
      }
      {
        mode = "n";
        key = "<leader>h2";
        action = mkFun "require('harpoon.ui').nav_file(2)";
        options.desc = "Harpoon: file 2";
      }
      {
        mode = "n";
        key = "<leader>h3";
        action = mkFun "require('harpoon.ui').nav_file(3)";
        options.desc = "Harpoon: file 3";
      }
      {
        mode = "n";
        key = "<leader>h4";
        action = mkFun "require('harpoon.ui').nav_file(4)";
        options.desc = "Harpoon: file 4";
      }

      # telescope
      {
        mode = "n";
        key = "<leader>pf";
        action = mkRaw "require('telescope.builtin').find_files";
        options.desc = "Telescope: search files";
      }
      {
        mode = "n";
        key = "<leader>pg";
        action = mkRaw "require('telescope.builtin').git_files";
        options.desc = "Telescope: search git staged files";
      }
      {
        mode = "n";
        key = "<leader>ps";
        action = mkFun "require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })";
        options.desc = "Telescope: grep files";
      }

      # neo-tree
      {
        mode = "n";
        key = "<leader>nt";
        action = mkCmd "Neotree toggle";
        options.desc = "Neotree: toggle";
      }

      # oil
      {
        mode = "n";
        key = "<leader>pv";
        action = mkRaw "require('oil').toggle_float";
        options.desc = "Oil: toggle float";
      }
    ];
  };
}
