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

-- Set jj to escape
keymap.set("i", "jj", "<Esc>")

-- Remap space + w to write a buffer
keymap.set("n", "<Space>w", "<Cmd>confirm w<CR>")

-- Remap space + q to quit
keymap.set("n", "<Space>q", "<Cmd>confirm q<CR>")

-- Remap buffer stuffs
keymap.set("n", "<leader>c", "<Cmd>confirm bd<CR>")
keymap.set("n", "H", "<Cmd>bprev<CR>")
keymap.set("n", "L", "<Cmd>bnext<CR>")

-- New tab
-- keymap.set("n", "te", "<Cmd>tabedit<CR>", { silent = true })
-- Split window
keymap.set("n", "ss", ":split ", { silent = false })
keymap.set("n", "sv", ":vsplit ", { silent = false })
-- Move window
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "<C-h>", "<C-w>h")
keymap.set("", "<C-k>", "<C-w>k")
keymap.set("", "<C-j>", "<C-w>j")
keymap.set("", "<C-l>", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><<<<")
keymap.set("n", "<C-w><right>", "<C-w>>>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
