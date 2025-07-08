{
  lib,
  config,
  username,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    #withUWSM = true;
  };
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;
  users.extraUsers.greeter = {
    home = "/tmp/greeter-home";
    createHome = true;
  };
  programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = lib.getExe config.programs.hyprland.package;
        user = config.users.users.${username}.name;
      };
    };
  };
}
