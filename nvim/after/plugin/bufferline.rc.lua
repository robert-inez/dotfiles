local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

local mocha = require("catppuccin.palettes").get_palette("mocha")
-- TokyoNight comment out highlights
bufferline.setup({
	highlights = require("catppuccin.groups.integrations.bufferline").get({
		styles = { "italic", "bold" },
		custom = {
			all = {
				fill = { bg = "#000000" },
			},
			mocha = {
				background = { fg = mocha.text },
			},
			latte = {
				background = { fg = "#000000" },
			},
		},
	}),
	options = {
		mode = "tabs",
		show_tab_indicators = true,
		show_buffer_close_icons = false,
		show_buffer_icons = true,
		show_close_icon = false,
		color_icons = true,
	},
})

vim.keymap.set("n", "L", "<Cmd>BufferLineCycleNext<CR>", {})
vim.keymap.set("n", "H", "<Cmd>BufferLineCyclePrev<CR>", {})
