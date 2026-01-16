{cmd}: {pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd \"${cmd}\"";
        user = "greeter";
      };
    };
  };

  users.users.greeter = {
    isSystemUser = true;
    description = "Greetd greeter user";
    createHome = false;
    group = "greeter";
    extraGroups = ["video"];
  };

  users.groups.greeter = {};

  systemd.tmpfiles.rules = [
    "d /etc/greetd 755 root root -"
    "Z /etc/greetd/* 644 root root -"
  ];
}
