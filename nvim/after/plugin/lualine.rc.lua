local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "kanagawa",
		section_separators = { left = "", right = "" }, -- 
		component_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		-- --[[ lualine_c = {
		--   {
		--     "filename",
		--     file_status = true, -- displays file status (readonly status, modified status)
		--     path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
		--   },
		-- }, ]]
		lualine_c = {
			{
				'buffers',
				show_filename_only = true,      -- Shows shortened relative path when set to false.
				hide_filename_extension = false, -- Hide filename extension when set to true.
				show_modified_status = true,    -- Shows indicator when the buffer is modified.
				mode = 0,                       -- 0: Shows buffer name
				max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
				-- buffers_color = {
				--   -- Same values as the general color option can be used here.
				--   active = 'lualine_{section}_normal',     -- Color for active buffer.
				--   inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
				-- },
				symbols = {
					modified = ' ●', -- Text to show when the buffer is modified
					alternate_file = '#', -- Text to show to identify the alternate file
					directory = '', -- Text to show when the buffer is a directory
				},
			},
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			"encoding",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location",
			-- "os.date('%H:%M')"
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{
				"filename",
				file_status = true, -- displays file status (readonly status, modified status)
				path = 1,       -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "fugitive" },
})
