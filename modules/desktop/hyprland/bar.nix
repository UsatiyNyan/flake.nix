{...}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        # modules-right = [
        #   "hyprland/language"
        #   "pulseaudio"
        #   "battery"
        #   "clock"
        #   "tray"
        # ];

        "hyprland/window".separate-outputs = true;
        # "hyprland/workspaces" = {
        #   disable-scroll = true;
        #   show-special = true;
        #   special-visible-only = true;
        #   all-outputs = false;
        #   format = "{icon}";
        #   format-icons = {
        #     "1" = "";
        #     "2" = "";
        #     "3" = "";
        #     "4" = "";
        #     "5" = "";
        #     "6" = "";
        #     "7" = "";
        #     "8" = "";
        #     "9" = "";
        #     "magic" = "";
        #   };
        #
        #   persistent-workspaces = {
        #     "*" = 9;
        #   };
        # };

        # "hyprland/language" = {
        #   format-en = "🇺🇸";
        #   format-ru = "🇷🇺";
        #   min-length = 5;
        #   tooltip = false;
        # };

        # "custom/weather" = {
        #   format = " {} ";
        #   exec = "curl -s 'wttr.in/Tashkent?format=%c%t'";
        #   interval = 300;
        #   class = "weather";
        # };

        # "pulseaudio" = {
        #   format = "{icon} {volume}%";
        #   format-bluetooth = "{icon} {volume}% ";
        #   format-muted = "";
        #   format-icons = {
        #     "headphones" = "";
        #     "handsfree" = "";
        #     "headset" = "";
        #     "phone" = "";
        #     "portable" = "";
        #     "car" = "";
        #     "default" = ["" ""];
        #   };
        #   on-click = "pavucontrol";
        # };

        # "battery" = {
        #   states = {
        #     warning = 30;
        #     critical = 1;
        #   };
        #   format = "{icon} {capacity}%";
        #   format-charging = " {capacity}%";
        #   format-alt = "{time} {icon}";
        #   format-icons = ["" "" "" "" ""];
        # };

        # "clock" = {
        #   format = "{:%d.%m.%Y - %H:%M}";
        #   format-alt = "{:%A, %B %d at %R}";
        # };
        #
        # "tray" = {
        #   icon-size = 14;
        #   spacing = 1;
        # };
      };
    };
    style = ./bar.css;
  };
}
