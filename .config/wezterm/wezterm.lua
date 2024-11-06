local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.color_scheme = 'tokyonight_night'

config.font_size = 14.0
config.font = wezterm.font('Monaspace Neon')
config.harfbuzz_features = { 'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09' }

config.audible_bell = 'Disabled'

config.enable_tab_bar = false
wezterm.on('format-window-title', function()
    return 'WezTerm'
end)

config.window_background_opacity = 0.9
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.adjust_window_size_when_changing_font_size = false

return config
