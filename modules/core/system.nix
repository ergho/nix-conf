{ pkgs, inputs, ... }:
{
  #nix = {
  #  settings = {
  #    auto-optimise-store = true;
  #    experimental-features = [
  #      "nix-command"
  #      "flakes"
  #    ];
  #    warn-dirty = false;
  #  };
  #  gc = {
  #    automatic = true;
  #    dates = "weekly";
  #    options = "--delete-older-than +3";
  #  };
  #};
  environment.systemPackages = with pkgs; [
    git
    vim
  ];
  #time.timeZone = "Europe/Stockholm";
  #i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.05";
}
