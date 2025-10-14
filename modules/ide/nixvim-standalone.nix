{
  inputs,
  system,
  my,
  lib,
  additionalComponents ? [],
  ...
} @ args:
inputs.nixvim.legacyPackages."${system}".makeNixvim {
  config = lib.mkMerge (map (x: x args) (
    with my.modules.ide.nixvim-components;
    [
      settings.autocmd
      settings.remap
      settings.set
      plugins.code
      plugins.colors
      plugins.fonts
      plugins.navigation
      plugins.notes
    ]
    ++ additionalComponents
  ));
}
