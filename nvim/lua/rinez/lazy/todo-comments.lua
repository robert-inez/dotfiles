return {
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    local status, comments = pcall(require, 'todo-comments')
    if not status then
      return
    end

    comments.setup({})
  end,
}
