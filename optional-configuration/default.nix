{
  boot = ./boot.nix;

  # display managers
  sddm = ./sddm.nix;
  ly = ./ly.nix;

  # display protocols
  x11 = ./x11.nix;

  # desktop environments
  plasma6 = ./plasma6.nix;
  hyprland = ./hyprland.nix;

  # file managers
  thunar = ./thunar.nix;
  dolphin = ./dolphin.nix;
  nautilus = ./nautilus.nix;

  # credential storage
  gnome-keyring = ./gnome-keyring.nix;

  # keyboard configuration
  vial = ./vial.nix;

  #
  box = ./box.nix;
}
