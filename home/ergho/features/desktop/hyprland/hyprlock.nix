{ config, lib, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      animations = {
        enabled = true;
        bezier = [
          "easeout,0.5, 1, 0.9, 1"
          "easeoutblack,0.34,1.22,0.65,1"
        ];
        animation = [
          "fade, 1, 3, easeout"
          "inputField, 1, 1, easeoutblack"
        ];
      };
      background = [
        {
          path = "screenshot";
          blur_passes = 4;
        }
      ];
      input-field = [
        {
          monitor = "";
          outline_thickness = 5;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0,0,0,0)";
          inner_color = "rgba(0,0,0,0.2)";
          font_color = "rgb(111,45,104)";
          fade_on_empty = false;
          rounding = -1;
          check_color = "rgb(111, 45, 104)";
          placeholder_text = "Password...";
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
  wayland.windowManager.hyprland = {
    settings = {
      bind =
        let
          hyprlock = lib.getExe config.programs.hyprlock.package;
        in
        [
          "SUPER,backspace,exec,${hyprlock}"

        ];
    };
  };
}
