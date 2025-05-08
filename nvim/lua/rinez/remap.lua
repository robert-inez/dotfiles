local keymap = vim.keymap

vim.g.mapleader = ' '

keymap.set('n', 'x', '"_x')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Set jj to escape
keymap.set('i', 'jj', '<Esc>')

-- Remap space + w to write a buffer
keymap.set('n', '<leader>w', '<Cmd>FormatWrite<CR>')

-- Remap space + q to quit
keymap.set('n', '<leader>q', '<Cmd>confirm q<CR>')

keymap.set('n', '<leader>f', '<Cmd>Format<CR>')

-- Open Oil
keymap.set('n', '<leader>tb', '<Cmd>Oil<CR>', { desc = 'Open Oil' })

-- Close buffer
keymap.set('n', '<leader>cb', '<Cmd>confirm bd<CR>')

-- Close buffer without closing split
keymap.set('n', '<leader>w', '<cmd>bp|bd #<CR>', { desc = 'Close Buffer; Retain Split' })

-- Get out Q
keymap.set('n', 'Q', '<nop>')

keymap.set('n', 'H', '<Cmd>bprev<CR>', { desc = 'switch to prev buffer' })
keymap.set('n', 'L', '<Cmd>bnext<CR>', { desc = 'switch to next buffer' })

-- Keep window centered when going up/down
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-- Paste without overwriting register
keymap.set('x', '<leader>p', "'_dP")

-- Split window
keymap.set('n', '<leader>ss', ':split ', {
  silent = false,
})
keymap.set('n', '<leader>sv', ':vsplit ', {
  silent = false,
})
-- Move window
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', '<C-h>', '<C-w>h')
keymap.set('', '<C-k>', '<C-w>k')
keymap.set('', '<C-j>', '<C-w>j')
keymap.set('', '<C-l>', '<C-w>l')

-- Resize window
-- keymap.set('n', '<C-w><left>', '<C-w><')
-- keymap.set('n', '<C-w><right>', '<C-w>>')
-- keymap.set('n', '<C-w><up>', '<C-w>+')
-- keymap.set('n', '<C-w><down>', '<C-w>-')

-- Resize with arrows
keymap.set('n', '<C-S-Down>', ':resize +2<CR>', { desc = 'Resize Horizontal Split Down' })
keymap.set('n', '<C-S-Up>', ':resize -2<CR>', { desc = 'Resize Horizontal Split Up' })
keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize Vertical Split Down' })
keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize Vertical Split Up' })

-- Move block
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move Block Down' })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move Block Up' })

keymap.set('', '<C-h>', '<Cmd> tmuxnavigateleft<CR>')
keymap.set('', '<C-l>', '<Cmd> tmuxnavigateright<CR>')
keymap.set('', '<C-j>', '<Cmd> tmuxnavigateup<CR>')
keymap.set('', '<C-k>', '<Cmd> TmuxNavigateDown<CR>')

keymap.set('n', '<leader><leader>', function()
  vim.cmd('so')
end)
