{...}: {
  colorschemes = {
    rose-pine = {
      enable = true;
      settings = {
        variant = "main";
        disable_background = true;
        disable_float_background = true;
      };
    };

    onedark = {
      enable = true;
      settings = {
        style = "darker";
        transparent = true;
      };
    };

    cyberdream = {
      enable = true;
      settings.transparent = true;
    };
  };

  colorscheme = "rose-pine";

  highlightOverride = {
    Normal = {bg = "none";};
    NormalNC = {bg = "none";};
    NormalFloat = {bg = "none";};
    EndOfBuffer = {bg = "none";};
    LineNr = {bg = "none";};
    SignColumn = {bg = "none";};
    StatusLine = {bg = "none";};
    StatusLineNC = {bg = "none";};
  };

  keymaps = [
    # Toggle light theme
    {
      mode = "n";
      key = "<leader>tl";
      action = "<cmd>colorscheme cyberdream-light<CR>";
      options.desc = "[T]heme: [L]ight";
    }
    {
      mode = "n";
      key = "<leader>td";
      action = "<cmd>colorscheme rose-pine-main<CR>";
      options.desc = "[T]heme: [D]ark";
    }
  ];
}
