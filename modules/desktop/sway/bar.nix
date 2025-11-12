{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["sway/workspaces"];
        modules-center = ["sway/window"];
        modules-right = [
          "keyboard-state"
          "pulseaudio"
          "battery"
          "clock"
        ];

        "sway/workspaces" = {
          format = "[{icon}]";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
            "active" = "_";
          };
          disable-scroll = false;
          all-outputs = true;
        };

        "sway/window" = {
          max-length = 60;
          separate-outputs = true;
        };

        "keyboard-state" = {
          format = "{layout}";
          format-alt = "{variant}";
          interval = 1;
        };

        "pulseaudio" = {
          states = {
            none = 20;
            good = 40;
            warning = 60;
            critical = 100;
          };
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = " 00%";
          format-icons = {
            "default" = ["" ""];
          };
          on-click-right = "pavucontrol";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "battery" = {
          states = {
            good = 70;
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%d.%m.%Y}";
          tooltip = true;
          tooltip-format = "{calendar}";
          calendar = {
            format = {
              today = "<b><u>{}</u></b>";
            };
          };
          actions = {
            on-click = "shift_reset";
            on-scroll-down = "shift_up";
            on-scroll-up = "shift_down";
          };
        };
      };
    };
    style = ./bar.css;
  };
}
