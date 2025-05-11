# notification daemon
{pkgs, ...}: {
  home = {
    packages = with pkgs; [mako];
    # based on inputs.mako-rose-pine + /theme/rose-pine.theme;
    file.".config/mako/config".text = ''
      background-color=#26233ad9
      text-color=#e0def4
      border-color=#524f67
      progress-color=over #31748f

      [urgency=high]
      border-color=#eb6f92
    '';
  };
}
