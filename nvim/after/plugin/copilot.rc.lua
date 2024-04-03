local keymap = vim.keymap

vim.g.copilot_filetypes = { markdown = false }
vim.g.copilot_no_tab_map = true

keymap.set('i', '<C-e>', 'copilot#Accept("<CR>")', {
  expr = true,
  replace_keycodes = false,
  silent = true,
})
