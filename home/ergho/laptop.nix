{ host, ... }:
{
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/desktop/wireless
    ./features/desktop/kanshi.nix
    #./features/desktop/peripherals
    #./features/work
  ];

  #monitor conf will be put here later
}
