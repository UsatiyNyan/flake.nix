{config, ...}: let
  helpers = config.lib.nixvim;
  mkRaw = helpers.mkRaw;
  mkFun = x: mkRaw ("function () " + x + " end");
  mkCmd = x: "<cmd>" + x + "<CR>";
in {
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;

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

      zen-mode = {
        enable = true;
        settings = {
          on_open = ''
            function()
              _G._zen_state = {
                foldcolumn = vim.o.foldcolumn
              }

              vim.o.foldcolumn = "0"
            end
          '';
          on_close = ''
            function()
              local state = _G._zen_state
              _G._zen_state = nil

              vim.o.foldcolumn = state.foldcolumn
            end
          '';
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

      # telescope
      {
        mode = "n";
        key = "<leader>pf";
        action = mkFun "require('telescope.builtin').find_files()";
        options.desc = "Telescope: search files";
      }
      {
        mode = "n";
        key = "<leader>pg";
        action = mkFun "require('telescope.builtin').git_files()";
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

      # zen-mode
      {
        mode = "n";
        key = "<leader>zm";
        action = mkCmd "ZenMode";
        options.desc = "ZenMode";
      }
    ];
  };
}
