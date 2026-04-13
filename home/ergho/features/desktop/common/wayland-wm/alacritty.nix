{ pkgs }:
{
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "Alacritty.desktop";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      #terminal.shell = {
      #  args = [
      #    "new-session"
      #    "-A"
      #    "-D"
      #    "-s"
      #    "main"
      #  ];
      #  program = "${pkgs.tmux}/bin/tmux";
      #};
      keyboard.bindings = [
        {
          key = "N";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
      ];
    };
  };
}
