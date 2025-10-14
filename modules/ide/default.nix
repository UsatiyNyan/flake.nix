{
  neovim = ./neovim.nix;

  nixvim-components = import ./nixvim-components;
  nixvim = ./nixvim;
  nixvim-standalone = ./nixvim-standalone.nix;

  # AI
  aider = ./aider.nix;
}
