{
  config,
  lib,
  pkgs,
  ...
}: {
  options.swayidle.enableSuspend = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether swayidle should suspend the system after a timeout.";
  };

  config = {
    # screen locker
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects; # optional for blur, etc.
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

    # idle daemon
    services.swayidle = {
      enable = true;
      systemdTarget = "graphical-session.target";

      timeouts =
        [
          {
            timeout = 180;
            command = "brightnessctl -s set 30";
            resumeCommand = "brightnessctl -r";
          }
          {
            timeout = 300;
            command = "swaylock -f";
          }
          {
            timeout = 600;
            command = "swaymsg 'output * dpms off'";
            resumeCommand = "swaymsg 'output * dpms on'";
          }
        ]
        ++ lib.optional config.swayidle.enableSuspend {
          timeout = 1200;
          command = "systemctl suspend";
        };

      events = [
        {
          event = "before-sleep";
          command = "swaylock -f";
        }
        {
          event = "after-resume";
          command = "swaymsg 'output * dpms on'";
        }
      ];
    };
  };
}
