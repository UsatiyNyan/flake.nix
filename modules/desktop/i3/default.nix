{...} @ args: {
  config,
  pkgs,
  ...
}: {
  imports = [
    (import ./binds.nix args)
  ];

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;

    config = {
      terminal = "alacritty -e my-tmux-attach";
      modifier = "Mod4";

      defaultWorkspace = "workspace number 1";

      window = {
        border = 0;
        hideEdgeBorders = "both";
        titlebar = true;
      };

      gaps = {
        inner = 0;
        outer = 0;
      };
    };
  };
}
