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

      # catpuccin.enable = true;

      onedark = {
        enable = true;
        settings.style = "deep";
      };

      oxocarbon.enable = true;
    };

    colorscheme = "rose-pine";
  };
}
