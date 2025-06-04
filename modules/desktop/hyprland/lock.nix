{
  # pam services configured in optional-configuration/hyprland.nix
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 2;
        hide_cursor = true;
        no_fade_in = false;
      };

      label = [
        {
          text = "$TIME";
          font_size = 96;
          font_family = "Iosevka Nerd Font";
          color = "rgba(224, 222, 244, 1.0)";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        {
          text = "$LAYOUT";
          font_size = 16;
          font_family = "Iosevka Nerd Font";
          color = "rgba(224, 222, 244, 1.0)";
          position = "0, 0";
          halign = "right";
          valign = "top";
        }
        {
          text = "λ";
          font_size = 24;
          font_family = "Iosevka Nerd Font";
          color = "rgba(224, 222, 244, 1.0)";
          position = "0, -80";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
      ];

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          monitor = "";
          hide_input = true;

          size = "64, 64";
          position = "0, -80";
          dots_center = true;
          outline_thickness = 8;

          inner_color = "rgba(25, 23, 36, 1.0)";
          outer_color = "rgba(31, 29, 46, 0.85)";
          check_color = "rgba(110, 106, 134, 1.0)";
          fail_color = "rgba(235, 111, 146, 1.0)";

          placeholder_text = "";
          fail_text = "";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "brightnessctl -s set 30";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1200;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
