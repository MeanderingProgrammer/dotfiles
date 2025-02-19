local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'tokyonight_night'

config.font_size = 14.0
config.font = wezterm.font('Monaspace Neon Frozen')

config.audible_bell = 'Disabled'

config.max_fps = 120
config.front_end = 'WebGpu'

config.enable_tab_bar = false
wezterm.on('format-window-title', function()
    return 'WezTerm'
end)

config.window_background_opacity = 0.9
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.adjust_window_size_when_changing_font_size = false

return config
