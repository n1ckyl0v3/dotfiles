local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- fonts
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13

-- theme
config.color_scheme = "Solarized (dark) (terminal.sexy)"
-- config.color_scheme = "Solarized Dark Higher Contrast"

-- Tabs
config.hide_tab_bar_if_only_one_tab = true

-- Position
config.initial_cols = 120
config.initial_rows = 35

-- Opacity
config.window_background_opacity = 0.4

return config
