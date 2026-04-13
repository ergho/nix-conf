{ pkgs, ... }:
let
  resurrectDir = "~/.config/tmux/resurrect";
  generatedConfig = "~/.config/tmux/tmux.conf";
in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    prefix = "C-a";
    sensibleOnTop = true;
    terminal = "xterm-256color";
    extraConfig = ''
      bind-key -n C-h select-pane -L
      bind-key -n C-j select-pane -D
      bind-key -n C-k select-pane -U
      bind-key -n C-l select-pane -R
      bind r source-file ${generatedConfig} \; display-message "${generatedConfig} Reloaded!"
    '';
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = gruvbox;
        extraConfig = ''set -g @tmux-gruvbox "dark"'';
      }
      #sensible
      yank
      tmux-thumbs
      pain-control
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pan-contents 'on'

          set -g @resurrect-dir ${resurrectDir}

        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
          set -g @continuum-systemd-start-cmd 'start-server'
        '';
      }
    ];
  };

  #  systemd.user.services.tmux = {
  #
  #    Unit = {
  #      description = "tmux server";
  #    };
  #    Service = {
  #      type = "forking";
  #      restart = "on-failure";
  #      ExecStart = "${lib.getExe' pkgs.bash "bash"} -c 'source ${generatedConfig} ; ${tmux} start-server'";
  #      ExecStop = tmux-graceful-stop;
  #      TimeoutStopSec = 10;
  #    };
  #    Install = {
  #      WantedBy = [ "default.target" ];
  #    };
  #  };
}
