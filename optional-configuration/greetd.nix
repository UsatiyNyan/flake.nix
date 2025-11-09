{cmd}: {pkgs, ...}: {
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${cmd}";
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
