{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpolkitagent
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    #xwayland.enable = false;
    settings = {

      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";
      "$mainMod" = "SUPER";
      "exec-once" = [
        "systemctl --user start hyprpolkitagent"
        "nm-applet --indicator"
      ];

      monitor = [
        "HDMI-A-1,1920x1080@60,0x0,1"
        "DP-1,2560x1440@144,1920x0,1"
        "DP-2,1920x1200@60,4480x0,1"
      ];

      env = [
        "NIXOS_OZONE_WL,1"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 5;
        "col.active_border" = "rgba(d65d0eff) rgba(98971aff) 45deg";
        "col.inactive_border" = "rgba(3c3836ff)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "master";
      };

      decoration = {
        rounding = 0;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = false;
        };
        blur = {
          enabled = false;
        };
      };

      animations = {
        enabled = "false";
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "slave";
        new_on_top = true;
        mfact = 0.5;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us,se";
        kb_options = "grp:alt_shift_toggle";

        follow_mouse = 1;

        sensitivity = 0;

        #touchpad = {
        #  natural_scroll = false;
        #};
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      workspace = [
        "1, monitor:DP-1"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-2"
        "5, monitor:DP-2"
        "6, monitor:DP-2"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "9, monitor:HDMI-A-1"
        "0, monitor:DP-1"
      ];
      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

    };
  };
}
