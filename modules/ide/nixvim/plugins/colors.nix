{
  programs.nixvim = {
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
          style = "warm";
          transparent = true;
        };
      };

      # catpuccin.enable = true;
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
  };
}
