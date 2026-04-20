-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon: add file' })
      vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon: menu' })
      vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Harpoon: file 1' })
      vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Harpoon: file 2' })
      vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Harpoon: file 3' })
      vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Harpoon: file 4' })
    end,
  },
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undotree: toggle' },
    },
  },
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    keys = {
      { '<leader>e', '<Cmd>Oil<CR>', desc = 'Oil: open file browser' },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    'zk-org/zk-nvim',
    name = 'zk',
    ft = 'markdown',
    config = function()
      require('zk').setup {
        picker = 'telescope',
        lsp = {
          config = {
            name = 'zk',
            cmd = { 'zk', 'lsp' },
            filetypes = { 'markdown' },
          },
          auto_attach = { enabled = true },
        },
      }

      local map = vim.keymap.set
      local opts = { noremap = true, silent = false }

      -- ── Navigation ────────────────────────────────────────────────
      map('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
      map('n', '<leader>zt', '<Cmd>ZkTags<CR>', opts)
      map('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
      map('v', '<leader>zf', ":'<,'>ZkMatch<CR>", opts)

      -- ── Create notes ──────────────────────────────────────────────
      map('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
      map('n', '<leader>zd', "<Cmd>ZkNew { dir = 'daily', template = 'daily.md', title = os.date('%Y%m%d') }<CR>", opts)
      map('n', '<leader>zcb', "<Cmd>ZkNew { template = 'bug.md', title = vim.fn.input('Bug: ') }<CR>", opts)
      map('n', '<leader>zcl', "<Cmd>ZkNew { template = 'learning.md', title = vim.fn.input('Learning: ') }<CR>", opts)
      map('n', '<leader>zcf', "<Cmd>ZkNew { template = 'feature.md', title = vim.fn.input('Feature: ') }<CR>", opts)
      map('n', '<leader>zcd', "<Cmd>ZkNew { template = 'decision.md', title = vim.fn.input('Decision: ') }<CR>", opts)
      map('n', '<leader>zcp', "<Cmd>ZkNew { template = 'permanent.md', title = vim.fn.input('Idea: ') }<CR>", opts)
    end,
  },
}
