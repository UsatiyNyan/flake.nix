{
  pkgs,
  config,
  my,
  lib,
  ...
}: {
  programs.nixvim = with my.modules.ide.nixvim-components;
    lib.mkMerge [
      (plugins.code {inherit pkgs config my;})
      (plugins.colors {})
      (plugins.fonts {})
      (plugins.navigation {inherit config my;})
      (plugins.notes {})
    ];
}
