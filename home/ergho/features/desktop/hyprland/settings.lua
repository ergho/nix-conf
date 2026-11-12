-- =========================================
-- Hyprland 0.57+
-- =========================================

-- Variables
local terminal = "alacritty"
local fileManager = "dolphin"
local menu = "wofi --show drun"
local mainMod = "SUPER"
local screenshotDir = os.getenv("HOME") .. "/screenshots"

-- =========================================
-- Environment
-- =========================================

hl.env("NIXOS_OZONE_WL", "1")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- =========================================
-- Startup
-- =========================================

hl.exec_cmd("systemctl --user start hyprpolkitagent")
hl.exec_cmd("nm-applet --indicator")

-- =========================================
-- Monitors
-- =========================================

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "DP-3",
  mode = "2560x1440@144",
  position = "1920x0",
  scale = 1,
})

hl.monitor({
  output = "DP-2",
  mode = "1920x1200@60",
  position = "4480x0",
  scale = 1,
})

-- =========================================
-- General
-- =========================================

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 5,

    col = {
      active_border = { colors = { "rgba(d65d0eff)", "rgba(98971aff)" }, angle = 45 },
      inactive_border = "rgba(3c3836ff)",
      --active_border = {
      --  "rgba(d65d0eff)",
      --  "rgba(98971aff)", --45deg",
      --},

      --inactive_border = 0xff3c3836,
    },
    --["col.active_border"] =
    --    "rgba(d65d0eff) rgba(98971aff) 45deg",

    --["col.inactive_border"] = "rgba(3c3836ff)",

    resize_on_border = false,
    allow_tearing = false,
    layout = "master",
  },

  -- Decoration
  decoration = {
    rounding = 0,
    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = false,
    },

    blur = {
      enabled = false,
    },
  },

  -- Animations
  animations = {
    enabled = false,
  },

  -- Dwindle
  dwindle = {
    preserve_split = true,
  },

  -- Master
  master = {
    new_status = "slave",
    new_on_top = true,
    mfact = 0.5,
  },

  -- Miscellaneous
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
  },

  -- Input
  input = {
    kb_layout = "us,se",
    kb_options = "grp:alt_shift_toggle",

    follow_mouse = 1,
    sensitivity = 0,
  },
})

-- =========================================
-- Devices
-- =========================================

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

-- =========================================
-- Keybindings
-- =========================================

-- Applications
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))

-- Focus movement
hl.bind(mainMod .. " + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + DOWN", hl.dsp.focus({ direction = "d" }))

-- Region select screenshot
hl.bind("SUPER + F", hl.dsp.exec_cmd("hyprshot -m region -o " .. screenshotDir))

-- Window screenshot
hl.bind("SUPER + W", hl.dsp.exec_cmd("hyprshot -m window -o " .. screenshotDir))

-- Screen lock (hyprlock)
hl.bind("SUPER + BACKSPACE", hl.dsp.exec_cmd("hyprlock"))

-- =========================================
-- Workspaces
-- =========================================

for i = 1, 10 do
  local key = tostring(i % 10)

  -- Switch workspace
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = tostring(i) }))

  -- Move window to workspace
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i) }))
end

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Workspace scrolling
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Fullscreen
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))

-- =========================================
-- Mouse bindings
-- =========================================

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())

hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- =========================================
-- Volume and brightness
-- =========================================

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))

hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"))

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"))

-- =========================================
-- Media controls
-- =========================================

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- =========================================
-- Workspace monitor assignments
-- =========================================

local workspaceMonitors = {
  { 1, "DP-3" },
  { 2, "DP-3" },
  { 3, "DP-3" },

  { 4, "DP-2" },
  { 5, "DP-2" },
  { 6, "DP-2" },

  { 7, "HDMI-A-1" },
  { 8, "HDMI-A-1" },
  { 9, "HDMI-A-1" },

  { 10, "DP-3" },
}

for _, ws in ipairs(workspaceMonitors) do
  hl.workspace_rule({
    workspace = tostring(ws[1]),
    monitor = ws[2],
  })
end
