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
        opacity = 1.0;
        startup_mode = "Maximized";
        dynamic_title = true;
      };

      font = {
        size = 15.0;

        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };

        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "JetBrainsMono Nerd Font";
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
