{...}: {
  plugins = {
    vimwiki = {
      enable = true;
      settings = {
        list = [
          {
            ext = ".md";
            path = "~/Documents/notes/";
            syntax = "markdown";
          }
        ];
      };
    };
  };
}
