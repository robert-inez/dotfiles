local keymap =
  vim.keymap

vim.g.mapleader =
  ' '

keymap.set(
  'n',
  'x',
  '"_x'
)

-- Increment/decrement
keymap.set(
  'n',
  '+',
  '<C-a>'
)
keymap.set(
  'n',
  '-',
  '<C-x>'
)

-- Select all
keymap.set(
  'n',
  '<C-a>',
  'gg<S-v>G'
)

-- Set jj to escape
keymap.set(
  'i',
  'jj',
  '<Esc>'
)


keymap.set(
  'n',
  '<leader>sf',
  '<Cmd>Explore<CR>'
)


-- Remap space + w to write a buffer
keymap.set(
  'n',
  '<leader>w',
  '<Cmd>confirm w<CR>'
)

-- Remap space + q to quit
keymap.set(
  'n',
  '<leader>q',
  '<Cmd>confirm q<CR>'
)

keymap.set(
  'n',
  '<leader>f',
  '<Cmd>Format<CR>'
)

keymap.set(
  'n',
  '<leader>F',
  '<Cmd>FormatWrite<CR>'
)

-- Remap buffer stuffs
keymap.set(
  'n',
  '<leader>cb',
  '<Cmd>confirm bd<CR>'
)

keymap.set(
  'n',
  'H',
  '<Cmd>bprev<CR>'
)
keymap.set(
  'n',
  'L',
  '<Cmd>bnext<CR>'
)

-- Split window
keymap.set(
  'n',
  '<leader>ss',
  ':split ',
  {
    silent = false,
  }
)
keymap.set(
  'n',
  '<leader>sv',
  ':vsplit ',
  {
    silent = false,
  }
)
-- Move window
keymap.set(
  'n',
  '<Space>',
  '<C-w>w'
)
keymap.set(
  '',
  '<C-h>',
  '<C-w>h'
)
keymap.set(
  '',
  '<C-k>',
  '<C-w>k'
)
keymap.set(
  '',
  '<C-j>',
  '<C-w>j'
)
keymap.set(
  '',
  '<C-l>',
  '<C-w>l'
)

-- Resize window
keymap.set(
  'n',
  '<C-w><left>',
  '<C-w><<<<'
)
keymap.set(
  'n',
  '<C-w><right>',
  '<C-w>>>>'
)
keymap.set(
  'n',
  '<C-w><up>',
  '<C-w>+'
)
keymap.set(
  'n',
  '<C-w><down>',
  '<C-w>-'
)
