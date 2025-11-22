{ host, ... }:
{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/games
  ];
}
