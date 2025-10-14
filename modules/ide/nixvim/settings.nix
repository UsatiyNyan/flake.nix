{
  config,
  user,
  my,
  lib,
  ...
}: {
  programs.nixvim = with my.modules.ide.nixvim-components;
    lib.mkMerge [
      (settings.autocmd {inherit config;})
      (settings.remap {inherit config;})
      (settings.set {inherit user config;})
    ];
}
