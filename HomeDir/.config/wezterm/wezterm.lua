-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Aci (Gogh)'
-- config.color_scheme = 'Dark+'
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Afterglow'
-- config.color_scheme = 'Darktooth (base16)'

config.default_cursor_style = 'BlinkingBar'
-- The following 3 lines makes the cursor blink and not fade
-- config.animation_fps = 1
-- config.cursor_blink_ease_in = 'Constant'
-- config.cursor_blink_ease_out = 'Constant'


-- and finally, return the configuration to wezterm
return config
