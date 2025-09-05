{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      background = [
        {
          monitor = "";
          blur_passes = 2;
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "600, 100";
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
}
