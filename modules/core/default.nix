{ ... }:
{
  imports = [
    ./bootloader.nix
    ./flatpak.nix
    #./fonts.nix
    #./hardware.nix
    ./neovim.nix
    #./network.nix
    ./packages.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    #./user.nix
    ./virtualisation.nix
    ./wayland.nix
  ];
}
