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
keymap.set("n", "<Space>w", ":w<Return>")

-- Remap space + q to quit
keymap.set("n", "<Space>q", ":confirm qa<CR>")

-- Remap space + c to close current buffer
keymap.set("n", "<Space>c", ":bd<Return>")

-- New tab
-- keymap.set('n', 'te', ':tabedit<Return>')
keymap.set("n", "te", ":tabedit")
-- Split window
keymap.set("n", "ss", ":split<Return><C-w>w")
keymap.set("n", "sv", ":vsplit<Return><C-w>w")
-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "sh", "<C-w>h")
keymap.set("", "sk", "<C-w>k")
keymap.set("", "sj", "<C-w>j")
keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")