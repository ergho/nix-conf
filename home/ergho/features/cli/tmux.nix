{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    terminal = "xterm-256color";
    extraConfig = ''
      unbind C-b
      set -g prefix C-a
      bind-key C-a send-prefix

      bind-key -n C-h select-pane -L
      bind-key -n C-j select-pane -D
      bind-key -n C-k select-pane -U
      bind-key -n C-l select-pane -R
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Reloaded!"
    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.pain-control
      { 
        plugin = tmuxPlugins.gruvbox;
	extraConfig = ''set -g @tmux-gruvbox "dark"'';
      }
    ];
  };
}
