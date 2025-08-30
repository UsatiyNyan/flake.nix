{...}: {
  programs.nixvim = {
    plugins = {
      vimwiki.enable = true;
      cmp-vimwiki-tags.enable = true;
    };
  };
}
