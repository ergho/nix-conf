{ pkgs, ... }:

{
  fonts = {
    packges = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
