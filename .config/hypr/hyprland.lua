hl.monitor({
  -- output = "",
  output = "HDMI-A-1",
  mode = "1920x1080@100",
  position = "0x0",
  scale = 1
})

local mainMod = "SUPER"
local terminal = "alacritty"
local fileManager = "thunar"
local browser = "zen-browser"
local menu = "rofi -show drun -theme ~/.config/rofi/launcher.rasi"

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_SCALE", "1")
hl.env("MOZ_ENABLE_WAYLANAD", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("APPIMAGELAUNCHER_DISABLE", "1")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("HYPRSHOT_DIR", "Screenshots")

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 4,
    border_size = 0,
    layout = "master",
    resize_on_border = true,
    hover_icon_on_border = true,
    allow_tearing = false
  },
  decoration = {
    rounding = 16,
    rounding_power = 2,

    blur = {
      enabled = true,
      size = 8,
      passes = 2,
      noise = 0,
      contrast = 1.25,
      brightness = 0.5,
      vibrancy = 1,
      vibrancy_darkness = 0,
      ignore_opacity = true,
      new_optimizations = true,
      special = true,
      xray = false,
      popups = true,
      popups_ignorealpha = 0.0,
      input_methods = true,
      input_methods_ignorealpha = 0.0
    },
    shadow = {
      enabled = true,
      range = 4,
      render_power = 2,
      color = "#00ff00",
      color_inactive = "#ff0000",
    }
  },
  animations = {
    enabled = true
  },
  input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.bind(mainMod .. " + X", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("wlogout -b 4"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("~/config/hypr/scripts/reload.sh"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- hl.bind(mainMod .. " + 1", hl.workspace(1))
-- hl.bind("SUPER + X", hl.workspace(1))
-- hl.bind("SUPER + C", hl.workspace(2))
-- hl.bind("SUPER + V", hl.workspace(3))
-- hl.bind("SUPER + S", hl.workspace(4))
-- hl.bind("SUPER + D", hl.workspace(5))
-- hl.bind("SUPER + F", hl.workspace(6))
-- hl.bind("SUPER + W", hl.workspace(7))
-- hl.bind("SUPER + E", hl.workspace(8))
-- hl.bind("SUPER + R", hl.workspace(9))
-- hl.bind("SUPER + SPACE", hl.workspace(10))
