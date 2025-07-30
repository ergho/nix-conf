{ ... }:

{
  services = {
    libinput.enable = true;
    fstrim.enable = true;
    #openssh = {
    #  enable = true;
    #  settings = {
    #    PermitRootLogin = "no";
    #    PasswordAuthentication = true;
    #  };
    #  ports = [ 22 ];
    #};
    printing.enable = true;
  };

  security.pam.services.gdm.enableGnomeKeyring = true;
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
}
