{
  host,
  ...
}:
let
  isDesktop = host == "desktop";
  isLaptop = host == "laptop";
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
        ignore_dbus_inhibit = true;
        lock_cmd = "pidof hyprlock || hyprlock";
      };
      listener =
        if isDesktop then
          [
            {
              timeout = 600;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 1200;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ]
        else if isLaptop then
          [
            {
              timeout = 300;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 600;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ]
        else
          [
            {
              timeout = 300;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 600;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
    };
  };
}
