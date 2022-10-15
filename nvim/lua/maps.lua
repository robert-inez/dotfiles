local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
-- keymap.set('n', 'dw', 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Set jj jk kj to escape
keymap.set("i", "jj", "<Esc>")
keymap.set("i", "jk", "<Esc>")
keymap.set("i", "kj", "<Esc>")

-- Remap space + w to write a buffer
keymap.set("n", "<Space>w", "<Cmd>w<CR>")

-- Remap space + q to quit
keymap.set("n", "<Space>q", "<Cmd>confirm qa<CR>")

-- Remap space + c to close current buffer
keymap.set("n", "<Space>c", "<Cmd>confirm bd<CR>")
keymap.set("n", "<Space>cr", "<Cmd>BufferLineCloseRight<CR>")
keymap.set("n", "<Space>cl", "<Cmd>BufferLineCloseLeft<CR>")

-- New tab
keymap.set("n", "te", "<Cmd>tabedit<CR>", { silent = true })
keymap.set("n", "tv", "<Cmd>Telescope telescope-tabs list_tabs<CR>", { silent = true })
-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true })
keymap.set("n", "sv", ":vsplit<Return><C-w>w", { silent = true })
keymap.set("n", "sc", "<C-w>q")
-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "<C-h>", "<C-w>h")
keymap.set("", "<C-k>", "<C-w>k")
keymap.set("", "<C-j>", "<C-w>j")
keymap.set("", "<C-l>", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
