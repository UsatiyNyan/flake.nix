{
  config,
  lib,
  ...
}: {
  options.swayidle.enableSuspend = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether swayidle should suspend the system after a timeout.";
  };

  config = {
    programs.swaylock = {
      enable = true;
      settings = {
        indicator-idle-visible = true;
        show-failed-attempts = false;
        font = "Iosevka Nerd Font";
        font-size = 24;
        color = "1f1d2e";
        inside-color = "191724ff";
        ring-color = "e0def4ff";
        key-hl-color = "eb6f92ff";
        text-color = "e0def4ff";
        ignore-empty-password = true;
        daemonize = true;
      };
    };

    services.swayidle = let
      lock = "${config.programs.swaylock.package}/bin/swaylock -f";
      display = status: "swaymsg 'output * dpms ${status}'";
    in {
      enable = true;

      timeouts =
        [
          {
            timeout = 180;
            command = "brightnessctl -s set 30";
            resumeCommand = "brightnessctl -r";
          }
          {
            timeout = 300;
            command = lock;
          }
          {
            timeout = 600;
            command = display "off";
            resumeCommand = display "on";
          }
        ]
        ++ lib.optional config.swayidle.enableSuspend {
          timeout = 1200;
          command = "systemctl suspend";
        };

      events = [
        {
          event = "before-sleep";
          command = "${display "off"}; ${lock}";
        }
        {
          event = "after-resume";
          command = display "on";
        }
        {
          event = "lock";
          command = "${display "off"}; ${lock}";
        }
        {
          event = "unlock";
          command = display "on";
        }
      ];
    };
  };
}
