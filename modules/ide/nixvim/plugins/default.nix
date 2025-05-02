let
  mkCmd = x: "<cmd>" + x + "<CR>";
in
{
  imports = [
    ./colors.nix
    ./fonts.nix
    ./navigation.nix
  ];

  programs.nixvim = {
    plugins = {
      undotree.enable = true;
      fugitive.enable = true;
    };

    keymaps = [
      { mode = "n"; key = "<leader>u"; action = mkCmd "UndotreeToggle"; options.desc = "Undotree"; }
      { mode = "n"; key = "<leader>gg"; action = mkCmd "Git"; options.desc = "Git status"; }
    ];
  };
}
