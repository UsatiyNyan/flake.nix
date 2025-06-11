{
  config,
  user,
  ...
}: {
  programs.nixvim = {
    opts = {
      guicursor = "";
      number = true;
      relativenumber = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      smartindent = true;
      wrap = false;

      swapfile = false;
      backup = false;
      undodir = "${config.xdg.cacheHome}/nvim/undodir";
      undofile = true;
      clipboard = "unnamedplus";

      hlsearch = false;
      incsearch = true;

      termguicolors = true;
      scrolloff = 8;
      signcolumn = "yes";

      updatetime = 50;
      # colorcolumn = "100";

      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    extraConfigLua = ''
      vim.opt.isfname:append('@-@')

      vim.notify("Hewwo, ${user}!")
    '';
  };
}
