local status, saga = pcall(require, "lspsaga")
local keymap = vim.keymap
if not status then
	return
end

saga.init_lsp_saga({
	code_action_lightbulb = {
		enable = false,
		enable_in_insert = false,
		cache_code_action = true,
		sign = true,
		update_time = 150,
		sign_priority = 20,
		virtual_text = true,
	},
})

local opts = { noremap = true, silent = true }
keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("n", "gj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
