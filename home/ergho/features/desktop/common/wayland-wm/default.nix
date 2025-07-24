{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./cliphist.nix
    ./gammastep.nix
    ./imv.nix
    ./kitty.nix
    ./swayosd.nix
    ./waybar
    ./wofi.nix
    ./zathura.nix
  ];
  xdg.mimeApps.enable = true;
  home.packages = with pkgs; [
    wf-recorder
    wl-clipboard
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
  };
}
