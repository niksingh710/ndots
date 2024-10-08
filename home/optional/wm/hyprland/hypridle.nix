{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        unlock_cmd = "killall -q -s SIGUSR1 hyprlock";
        before_sleep_cmd = "loginctl lock-session; sleep 2";
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 240;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 300;
          on-timeout = "sleep 1 && hyprctl dispatch dpms off";
          on-resume = "sleep 1 && hyprctl dispatch dpms on";
        }

        {
          timeout = 420;
          on-timeout = "systemctl suspend";
        }
      ];

    };
  };
}
