local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "rose-pine"

config.font = wezterm.font("Monaspace Neon")
config.font_size = 14.0

config.window_background_opacity = 0.9
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

return config
