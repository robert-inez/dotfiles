local keymap = vim.keymap
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        -- Actions
        keymap.set('n', '<leader>gb', gs.toggle_current_line_blame)
      end,
    })
  end,
}
