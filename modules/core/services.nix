{ ... }:

{
  services = {
    libinput.enable = true;
    fstrim.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
      ports = [ 22 ];
    };
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };

  security.pam.services.gdm.enableGnomeKeyring = true;
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
}
