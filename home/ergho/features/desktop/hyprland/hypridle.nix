{
  host,
  lib,
  config,
  ...
}:
{
  services.hypridle = {
    enable = true;
    settings =
      let
        isDesktop = ''[ "${host}" = "desktop" ]'';
        isLaptop = ''[ "${host}" = "laptop" ]'';
        #isDesktop = host == "desktop";
        #isLaptop = host == "laptop";
        isLocked = "pgrep hyprlock";
        isDischarging = "grep Discharging /sys/class/power_supply/BAT{0,1}/status -q";
      in
      {
        general = {
          after_sleep_cd = "hyprctl dispatch dpms on";
          before_sleep_cmd = "loginctl lock-session";
          lock_cmd = "if ! ${isLocked}; then ${lib.getExe config.programs.hyprlock.package} --grace 5; fi";
          inhibit_sleep = 3; # Wait for lock before suspend
        };
        listener = [

          {
            timeout = 30;
            on-timeout = "brightnessctl --save";
            on-resume = "brightnessctl --restore";
          }
          {
            timeout = 50;
            on-timeout = "brightnessctl set 50%-";
          }
          {
            timeout = 180;
            on-timeout = "brightnessctl set 50%-";
          }
          # if laptop
          {
            timeout = 300;
            on-timeout = "if ${isLaptop}; then loginctl lock-session; fi";
          }
          # if desktop
          {
            timeout = 600;
            on-timeout = "if ${isDesktop}; then loginctl lock-session; fi";
          }
          # if locked
          {
            timeout = 15;
            on-timeout = "if ${isLocked}; then brightnessctl set 75%-; fi";
          }
          {
            timeout = 30;
            on-timeout = "if ${isLocked}; then hyprcyl dispatch dpms off; fi";
            on-resume = "hyprctl dispatch dpms on";
          }
          # If discharging
          {
            timeout = 900;
            on-timeout = "if ${isDischarging}; then systemctl suspend; fi";
          }
        ];
      };
  };
}
