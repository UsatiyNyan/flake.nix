{config, ...}: let
  helpers = config.lib.nixvim;
  mkRaw = helpers.mkRaw;
  mkFun = x: mkRaw ("function () " + x + " end");
  mkCmd = x: "<cmd>" + x + "<CR>";
in {
  programs.nixvim = {
    plugins = {
      tmux-navigator.enable = true;

      neo-tree.enable = true;
      oil = {
        enable = true;
        settings = {
          columns = ["icon"];
          keymaps."<C-h>" = false; # conflicts with Tmux
          view_options.show_hidden = true;
        };
      };

      snacks = {
        enable = true;
        autoLoad = true;
        settings = {
          picker = {
            enabled = true;
            layout = "ivy";
          };
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

      # snacks.picker
      {
        mode = "n";
        key = "<leader>km";
        action = mkFun ''Snacks.picker.keymaps({ layout = "vertical" })'';
        options.desc = "Snacks.picker: keymap";
      }
      {
        mode = "n";
        key = "<leader>pb";
        action = mkFun ''
          Snacks.picker.buffers({
            finder = "buffers",
            format = "buffer",
            hidden = false,
            unloaded = true,
            current = true,
            sort_lastused = true,
          })'';
        options.desc = "Snacks.picker: buffers";
      }
      {
        mode = "n";
        key = "<leader>pf";
        action = mkFun ''
          Snacks.picker.files({
            finder = "files",
            format = "file",
            show_empty = true,
            supports_live = true,
          })'';
        options.desc = "Snacks.picker: files";
      }
      {
        mode = "n";
        key = "<leader>ps";
        action = mkFun ''
          Snacks.picker.grep({
            finder = "grep",
            format = "file",
            regex = false,
            show_empty = true,
            supports_live = true,
          })'';
        options.desc = "Snacks.picker: grep";
      }
      {
        mode = "n";
        key = "<leader>pgf";
        action = mkFun ''
          Snacks.picker.git_files({
            finder = "git_files",
            format = "file",
            show_empty = true,
            untracked = true,
            submodules = true,
          })'';
        options.desc = "Snacks.picker: git files";
      }
      {
        mode = "n";
        key = "<leader>pgs";
        action = mkFun ''
          Snacks.picker.git_grep({
            finder = "git_grep",
            format = "file",
            show_empty = true,
            untracked = true,
            submodules = true,
            live = true,
          })'';
        options.desc = "Snacks.picker: git grep";
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
        key = "<leader>-";
        action = mkFun "require('oil').toggle_float()";
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
