{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
