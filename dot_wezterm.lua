local wezterm = require("wezterm")
local config = wezterm.config_builder()

local rose_pine_theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").moon
config.colors = rose_pine_theme.colors()
config.window_frame = rose_pine_theme.window_frame()

-- Rendering
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
config.webgpu_force_fallback_adapter = false
config.max_fps = 240

-- Fonts
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", { weight = "DemiBold" })
config.font_size = 22
config.cell_width = 0.9
config.bold_brightens_ansi_colors = true
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.freetype_load_flags = "NO_HINTING"

-- Underline settings (for nvim)
config.underline_thickness = 2
config.underline_position = -3

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
config.adjust_window_size_when_changing_font_size = false

-- Tabs
config.tab_max_width = 32

-- Keybinds
local mods = "CTRL|SHIFT"
local a = wezterm.action
config.keys = {
	-- Splits
	{ key = "|", mods = mods, action = a.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "Enter", mods = mods, action = a.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Split navigation
	{ key = "LeftArrow", mods = mods, action = a.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = mods, action = a.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = mods, action = a.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = mods, action = a.ActivatePaneDirection("Down") },

	-- Split Size
	{ key = "LeftArrow", mods = mods .. "|ALT", action = a.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = mods .. "|ALT", action = a.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = mods .. "|ALT", action = a.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = mods .. "|ALT", action = a.AdjustPaneSize({ "Down", 5 }) },

	-- Split close
	{ key = "w", mods = mods, action = a.CloseCurrentPane({ confirm = true }) },

	-- Tab Rename
	{
		key = "<", -- comma, but since I use shift it's a '<'
		mods = mods,
		action = a.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

return config
