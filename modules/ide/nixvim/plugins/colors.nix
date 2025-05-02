{
  programs.nixvim = {
    colorschemes = {
      rose-pine = {
        enable = true;
        settings.variant = "main";
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
