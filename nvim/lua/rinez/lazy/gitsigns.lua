return {
  'lewis6991/gitsigns.nvim',
  config = function()
    local status, gitsigns = pcall(require, 'gitsigns')
    if not status then
      return
    end

    gitsigns.setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        -- Actions
        vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame)
      end,
    })
  end,
}
