{
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    hyprshot
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind =
        let
          hyprshot = lib.getExe pkgs.hyprshot;
        in
        [
          "SUPER,F,exec,${hyprshot} -m output"

          # Region select screenshot
          "SUPER,R,exec,${hyprshot} -m region"

          # Window screenshot
          "SUPER,W,exec,${hyprshot} -m window"
        ];

    };
  };
}
