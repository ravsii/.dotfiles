local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Storm"

-- Rendering engine
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.webgpu_force_fallback_adapter = false

-- Fonts
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", { weight = "DemiBold" })
config.font_size = 22
config.cell_width = 0.9
config.bold_brightens_ansi_colors = true
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.freetype_load_flags = "NO_HINTING"

-- Padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Wezterm window
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.use_fancy_tab_bar = false

-- Tabs
config.tab_max_width = 32

-- Keybinds
local mods = "CTRL|SHIFT"
config.keys = {
	-- Splits
	{ key = "|", mods = mods, action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "Enter", mods = mods, action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Split navigation
	{ key = "LeftArrow", mods = mods, action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = mods, action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = mods, action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = mods, action = wezterm.action.ActivatePaneDirection("Down") },

	-- Split Size
	{ key = "LeftArrow", mods = mods .. "|ALT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = mods .. "|ALT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = mods .. "|ALT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = mods .. "|ALT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

	-- Split close
	{ key = "w", mods = mods, action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

return config
