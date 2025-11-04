{
  lib,
  my,
  ...
}: let
  helpers = my.lib.nixvim lib;
  inherit (helpers) mkFun mkCmd;
in {
  plugins = {
    tmux-navigator.enable = true;

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
        zen = {
          enabled = true;
          toggles = {
            dim = false;
            foldcolumn = false;
            number = false;
            relativenumber = false;
          };
          win.width = 130;
        };
      };
      luaConfig.post = ''
        Snacks.toggle.option("foldcolumn", { off = "0", on = vim.o.foldcolumn, global = true })
        Snacks.toggle.option("number", { off = false, on = vim.o.number, global = true })
        Snacks.toggle.option("relativenumber", { off = false, on = vim.o.relativenumber, global = true })
      '';
    };

    undotree.enable = true;
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
          current = true,
          sort_lastused = false,
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
          cmd = "rg",
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
    {
      mode = "n";
      key = "<leader>pc";
      action = mkFun ''
        Snacks.picker.cliphist({
          finder = "system_cliphist",
          format = "text",
          preview = "preview",
          confirm = { "copy", "close" },
        })'';
      options.desc = "Snacks.picker: clip hist";
    }

    {
      mode = "n";
      key = "<leader>pe";
      action = mkFun ''Snacks.picker.explorer()'';
      options.desc = "Snacks.picker: explorer";
    }

    # snacks.zen
    {
      mode = "n";
      key = "<leader>zm";
      action = mkFun ''Snacks.zen.zen({})'';
      options.desc = "Snacks.zen";
    }

    # oil
    {
      mode = "n";
      key = "<leader>-";
      action = mkFun "require('oil').toggle_float()";
      options.desc = "Oil: toggle float";
    }

    # undotree
    {
      mode = "n";
      key = "<leader>u";
      action = mkCmd "UndotreeToggle";
      options.desc = "Undotree";
    }
  ];
}
