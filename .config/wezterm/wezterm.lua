-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Spawn a zsh shell in login mode, launching tmux
--config.default_prog = { "/opt/homebrew/bin/zsh", "--login", "-c", "tmux attach 2>/dev/null || tmux" }
config.default_prog = { "/opt/homebrew/bin/zsh", "--login" }

-- Color scheme
config.color_scheme = "Tokyo Night"

-- Font
--config.font = wezterm.font({ family = "Monaspace Neon", weight = "Light" })
config.font_size = 12.1
-- Offset corrections for Monaspice Nerd Fonts
config.underline_position = -4
config.strikethrough_position = 14
-- Enable ligatures for all fonts where possible, specifically Monaspace
config.harfbuzz_features = {
	"calt",
	-- "dlig", -- discretionary ligatures, this enables the lot by design
	"ss01", -- ligatures related to the equals glyph like != and ===.
	"ss02", -- ligatures related to the greater than or less than operators.
	"ss03", -- ligatures related to arrows like -> and =>.
	"ss04", -- ligatures related to markup, like </ and />.
	"ss05=0", -- ligatures related to the F# programming language, like |>.
	"ss06", -- ligatures related to repeated uses of # such as ## or ###.
	"ss07", -- ligatures related to the asterisk like ***.
	"ss08", -- ligatures related to combinations like .= or .-.
	"liga",
}
config.font = wezterm.font_with_fallback({
	{ family = "MonaspiceNe Nerd Font Mono", weight = "Light" },
	{ family = "Monaspace Neon", weight = "Light" },
	"Noto Sans Symbols 2",
	"Noto Color Emoji",
	"Symbols Nerd Font Mono",
})
-- Override italic font use with Monaspace Radon
config.font_rules = {
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font_with_fallback({
			{
				family = "Monaspace Radon",
				weight = "Light",
			},
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font_with_fallback({
			{
				family = "Monaspace Radon",
				weight = "Medium",
			},
		}),
	},
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font_with_fallback({
			{
				family = "Monaspace Radon",
				weight = "ExtraLight",
			},
		}),
	},
}
-- config.font_rules = {
-- 	{
-- 		intensity = "Bold",
-- 		italic = false,
-- 		font = wezterm.font({
-- 			family = "Monaspace Neon",
-- 			weight = "DemiBold",
-- 		}),
-- 	},
-- 	{
-- 		italic = false,
-- 		intensity = "Half",
-- 		font = wezterm.font({
-- 			family = "Monaspace Neon",
-- 			weight = "ExtraLight",
-- 		}),
-- 	},
-- 	{
-- 		italic = false,
-- 		intensity = "Normal",
-- 		font = wezterm.font({
-- 			family = "Monaspace Neon",
-- 			weight = "Light",
-- 		}),
-- 	},
-- 	{
-- 		intensity = "Bold",
-- 		italic = true,
-- 		font = wezterm.font({
-- 			family = "Monaspace Radon",
-- 			weight = "DemiBold",
-- 		}),
-- 	},
-- 	{
-- 		italic = true,
-- 		intensity = "Half",
-- 		font = wezterm.font({
-- 			family = "Monaspace Radon",
-- 			weight = "ExtraLight",
-- 		}),
-- 	},
-- 	{
-- 		italic = true,
-- 		intensity = "Normal",
-- 		font = wezterm.font({
-- 			family = "Monaspace Radon",
-- 			weight = "Light",
-- 		}),
-- 	},
-- }
-- config.window_background_opacity = 0.45
-- config.macos_window_background_blur = 20
config.enable_tab_bar = false
-- config.debug_key_events = true
config.mouse_bindings = {
	-- Disable the 'Down' event of Cmd-Click to avoid weird program behaviors
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.Nop,
	},
	-- Cmd-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.OpenLinkAtMouseCursor,
	},
}

-- Bindings
--config.disable_default_key_bindings = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.use_ime = true
config.use_dead_keys = false
config.keys = {
	----------------------------------------------------------------------------------
	--- wezterm
	----------------------------------------------------------------------------------
	-- Increase font size: Cmd+Shift+Equal
	{ key = "=", mods = "CMD|SHIFT", action = act.IncreaseFontSize },
	-- Reset font size: Cmd+Shift+0
	{ key = "0", mods = "CMD|SHIFT", action = act.ResetFontSize },
	----------------------------------------------------------------------------------
	--- tmux
	----------------------------------------------------------------------------------
	-- move between tmux panes: Cmd+Shift+(HJKL) or Cmd+Shift+(Left Down Up Right) Arrow
	{ key = "h", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[D" }) },
	{ key = "j", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[B" }) },
	{ key = "k", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[A" }) },
	{ key = "l", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[C" }) },
	{ key = "LeftArrow", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[D" }) },
	{ key = "DownArrow", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[B" }) },
	{ key = "UpArrow", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[A" }) },
	{ key = "RightArrow", mods = "CMD|SHIFT", action = act({ SendString = "\x02\x1b[C" }) },
	-- Select window 0-9
	{ key = "1", mods = "CMD", action = act({ SendString = "\x021" }) },
	{ key = "2", mods = "CMD", action = act({ SendString = "\x022" }) },
	{ key = "3", mods = "CMD", action = act({ SendString = "\x023" }) },
	{ key = "4", mods = "CMD", action = act({ SendString = "\x024" }) },
	{ key = "5", mods = "CMD", action = act({ SendString = "\x025" }) },
	{ key = "6", mods = "CMD", action = act({ SendString = "\x026" }) },
	{ key = "7", mods = "CMD", action = act({ SendString = "\x027" }) },
	{ key = "8", mods = "CMD", action = act({ SendString = "\x028" }) },
	{ key = "9", mods = "CMD", action = act({ SendString = "\x029" }) },
	{ key = "0", mods = "CMD", action = act({ SendString = "\x020" }) },
	-- Previous/Next tmux window: Cmd+{/}
	{ key = "{", mods = "CMD|SHIFT", action = act({ SendString = "\x02p" }) },
	{ key = "}", mods = "CMD|SHIFT", action = act({ SendString = "\x02n" }) },
	--
	-- Zoom - Cmd+Z
	{ key = "z", mods = "CMD", action = act({ SendString = "\x02z" }) },
	-- Kill the current pane/last window - Cmd+W
	{ key = "w", mods = "CMD", action = act({ SendString = "\x02x" }) },
	-- Detach - Cmd+Shift+W
	{ key = "w", mods = "CMD|SHIFT", action = act({ SendString = "\x02d" }) },
	-- Split pane horizontally - Cmd+D
	{ key = "d", mods = "CMD", action = act({ SendString = "\x02|" }) },
	-- Split pane vertically - Cmd+Shift+D
	{ key = "d", mods = "CMD|SHIFT", action = act({ SendString = "\x02_" }) },
	-- Create new window - Cmd+T
	{ key = "t", mods = "CMD", action = act({ SendString = "\x02c" }) },
	-- Set split equal - Cmd+=
	{ key = "=", mods = "CMD", action = act({ SendString = "\x02E" }) },

	----------------------------------------------------------------------------------
	--- vim
	----------------------------------------------------------------------------------
	-- move between vim panes: Cmd+(HJKL) or Cmd+(Left Down Up Right) Arrow
	{ key = "h", mods = "CMD", action = act({ SendString = "\x17h" }) },
	{ key = "j", mods = "CMD", action = act({ SendString = "\x17j" }) },
	{ key = "k", mods = "CMD", action = act({ SendString = "\x17k" }) },
	{ key = "l", mods = "CMD", action = act({ SendString = "\x17l" }) },
	{ key = "LeftArrow", mods = "CMD", action = act({ SendString = "\x17h" }) },
	{ key = "DownArrow", mods = "CMD", action = act({ SendString = "\x17j" }) },
	{ key = "UpArrow", mods = "CMD", action = act({ SendString = "\x17k" }) },
	{ key = "RightArrow", mods = "CMD", action = act({ SendString = "\x17l" }) },

	-- Select all in nvim: Cmd+A
	{ key = "a", mods = "CMD", action = act({ SendString = "\x1bggVG" }) },
	-- save in nvim: Cmd+S
	{ key = "s", mods = "CMD", action = act({ SendString = "\x1b\x1b:w\n" }) },
	-- save all in nvim: Cmd+Shift+S
	{ key = "s", mods = "CMD|SHIFT", action = act({ SendString = "\x1b\x1b:wa\n" }) },
	-- save and cloe pane: Cmd+Opt+S
	{ key = "s", mods = "CMD|OPT", action = act({ SendString = "\x1b\x1bZZ" }) },
	-- open file picker in neovim: Cmd+P
	{ key = "p", mods = "CMD", action = act({ SendString = "\x1b\x1b sf\n" }) },
	-- Cmd+Shift+P - Select tmux session
	{ key = "p", mods = "CMD|SHIFT", action = act({ SendString = "\x02s" }) },

	-- bar bar
	{ key = ",", mods = "OPT", action = act({ SendString = "≤" }) },
	{ key = ".", mods = "OPT", action = act({ SendString = "≥" }) },
	-- Re-order to previous/next
	{ key = ",", mods = "SHIFT|OPT", action = act({ SendString = "¯" }) },
	{ key = ".", mods = "SHIFT|OPT", action = act({ SendString = "˘" }) },
	-- Goto buffer in position...
	-- { key = "1", mods = "OPT", action = act({ SendString = "¡" }) },
	-- { key = "2", mods = "OPT", action = act({ SendString = "™" }) },
	-- { key = "3", mods = "OPT", action = act({ SendString = "£" }) },
	-- { key = "4", mods = "OPT", action = act({ SendString = "¢" }) },
	-- { key = "5", mods = "OPT", action = act({ SendString = "∞" }) },
	-- { key = "6", mods = "OPT", action = act({ SendString = "§" }) },
	-- { key = "7", mods = "OPT", action = act({ SendString = "¶" }) },
	-- { key = "8", mods = "OPT", action = act({ SendString = "•" }) },
	-- { key = "9", mods = "OPT", action = act({ SendString = "ª" }) },
	-- { key = "0", mods = "OPT", action = act({ SendString = "º" }) },
	-- Pin/unpin buffer
	{ key = "p", mods = "OPT", action = act({ SendString = "π" }) },
	-- Close buffer
	{ key = "c", mods = "OPT", action = act({ SendString = "ç" }) },
	-- Close all but current
	{ key = "c", mods = "SHIFT|OPT", action = act({ SendString = "Ç" }) },
	-- Split pane horizontally - Opt+S
	{ key = "s", mods = "OPT", action = act({ SendString = "\x17s" }) },
	-- Split pane vertically - Opt+V
	{ key = "v", mods = "OPT", action = act({ SendString = "\x17v" }) },
	----------------------------------------------------------------------------------
	--- term
	----------------------------------------------------------------------------------
	-- Delete entire row - Cmd+Backspace
	{ key = "Backspace", mods = "CMD", action = act({ SendString = "\x15" }) },
	-- Delete entire word - Opt+Backspace
	{ key = "Backspace", mods = "OPT", action = act({ SendString = "\x17" }) },
}
-- config.keys = {
-- 	{ key = ")", mods = "SUPER", action = act.ResetFontSize },
-- 	{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },
-- 	{ key = "=", mods = "SUPER", action = act.IncreaseFontSize },
-- 	{ key = "N", mods = "SUPER", action = act.SpawnWindow },
-- 	{ key = "P", mods = "SUPER", action = act.ActivateCommandPalette },
-- 	{ key = "V", mods = "SUPER", action = act.PasteFrom("Clipboard") },
-- 	{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
-- 	{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
-- }

-- and finally, return the configuration to wezterm
return config
