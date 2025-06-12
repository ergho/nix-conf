{ ... }:

{
  hardware = {
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
    graphics.enable = true;
  };
  services.blueman.enable = true;
}
