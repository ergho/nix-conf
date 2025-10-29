{

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        profile.name = "office-docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL U2722D JFQP5P3";
            mode = "2560x1440@60Hz";
            position = "0,0";
          }
          {
            criteria = "Dell Inc. DELL U2722DE 8LSL5P3";
            mode = "2560x1440@60Hz";
            position = "2560,0";
          }
        ];
      }

      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      }
    ];
  };
}
