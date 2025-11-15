{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["sway/workspaces"];
        modules-center = ["sway/window"];
        modules-right = [
          "memory"
          "cpu"
          "network"
          "pulseaudio"
          "battery"
          "sway/language"
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
            "urgent" = "*";
            "focused" = "_";
          };
          disable-scroll = false;
          all-outputs = true;
        };

        "sway/window" = {
          max-length = 60;
          separate-outputs = true;
        };

        "cpu" = {
          states = {
            none = 20;
            good = 40;
            warning = 60;
            critical = 100;
          };
          interval = 10;
          format = " {usage}%";
          max-length = 10;
        };

        "memory" = {
          states = {
            none = 20;
            good = 40;
            warning = 60;
            critical = 100;
          };
          format = " {percentage}%";
          tooltip-format = "{used:0.1f}G/{total:0.1f}G";
        };

        "network" = {
          format-wifi = "{icon}{signalStrength}%";
          format-ethernet = " ";
          format-disconnected = "<span color='#EB6F92'> </span>";
          format-icons = [
            "<span color='#EB6F92'>󰤯 </span>"
            "<span color='#F6C177'>󰤟 </span>"
            "<span color='#F6C177'>󰤢 </span>"
            "<span color='#9CCFD8'>󰤥 </span>"
            "󰤨 "
          ];
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{essid}";
          tooltip-format-ethernet = "{ifname}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };

        "sway/language" = {
          format = "{shortDescription}";
          tooltip-format = "{long}";
          on-click = ''swaymsg input "*" xkb_switch_layout next'';
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

  wayland.windowManager.sway.config.bars = [
    {
      command = "${pkgs.waybar}/bin/waybar";
    }
  ];
}
