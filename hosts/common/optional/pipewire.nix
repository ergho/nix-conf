{ pkgs-stable, ... }:
{
  security.rtkit.enable = true;
  #services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    package = pkgs-stable.pipewire;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
      package = pkgs-stable.wireplumber;
    };
  };
}
