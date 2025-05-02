let
  mkCmd = x: "<cmd>" + x + "<CR>";
in
{
  imports = [
    ./colors.nix
  ];

  programs.nixvim = {
    plugins = {
      undotree.enable = true;
      fugitive.enable = true;
      tmux-navigator.enable = true;
    };

    keymaps = [
      { mode = "n"; key = "<leader>u"; action = mkCmd "UndotreeToggle"; options.desc = "Undotree"; }
      { mode = "n"; key = "<leader>gg"; action = mkCmd "Git"; options.desc = "Git status"; }
      { mode = "n"; key = "<C-h>"; action = mkCmd "TmuxNavigateLeft";  options.desc = "Tmux window left"; }
      { mode = "n"; key = "<C-j>"; action = mkCmd "TmuxNavigateDown";  options.desc = "Tmux window down"; }
      { mode = "n"; key = "<C-k>"; action = mkCmd "TmuxNavigateUp";    options.desc = "Tmux window up"; }
      { mode = "n"; key = "<C-l>"; action = mkCmd "TmuxNavigateRight"; options.desc = "Tmux window right"; }
    ];
  };
}
