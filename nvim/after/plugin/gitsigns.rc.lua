local status, gitsigns = pcall(require, "gitsigns")
if (not status) then return end

local keymap = vim.keymap
gitsigns.setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    -- Actions
    keymap.set('n', '<leader>gb', gs.toggle_current_line_blame)

  end
}
