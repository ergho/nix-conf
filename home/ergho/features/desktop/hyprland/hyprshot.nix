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
          screenshotDir = "$HOME/screenshots";
        in
        [
          # Region select screenshot
          "SUPER,F,exec,${hyprshot} -m region -o ${screenshotDir}"

          # Window screenshot
          "SUPER,W,exec,${hyprshot} -m window -o ${screenshotDir}"
        ];

    };
  };
}
