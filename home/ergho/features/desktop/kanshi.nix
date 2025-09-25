{

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      office-docked = {
        outputs = [
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
      };
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
          }
        ];
      };

    };
  };
}
