{
  config,
  inputs,
  ...
}: {
  home = {
    sessionVariables.TERMINAL = "alacritty";
    file.".config/alacritty/themes/rose-pine".source = inputs.alacritty-rose-pine + /dist;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      general.import = ["${config.xdg.configHome}/alacritty/themes/rose-pine/rose-pine.toml"];

      window = {
        decorations = "none";
        opacity = 0.85;
        startup_mode = "Maximized";
        dynamic_title = true;
        padding = {
          x = 0;
          y = 0;
        };
      };

      font = let
        aFont = "Iosevka Nerd Font";
      in {
        size = 16.0;

        normal = {
          family = aFont;
          style = "Regular";
        };

        bold = {
          family = aFont;
          style = "Bold";
        };

        italic = {
          family = aFont;
          style = "Italic";
        };

        bold_italic = {
          family = aFont;
          style = "Bold Italic";
        };

        offset = {
          x = 0;
          y = 0;
        };

        glyph_offset = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
