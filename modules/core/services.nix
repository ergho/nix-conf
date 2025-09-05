{ ... }:

{
  services = {
    libinput.enable = true;
    fstrim.enable = true;
  };

  security.pam.services.gdm.enableGnomeKeyring = true;
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
}
