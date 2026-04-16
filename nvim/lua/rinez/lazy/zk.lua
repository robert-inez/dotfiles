return {
  'zk-org/zk-nvim',
  name = 'zk',
  config = function()
    require('zk').setup({
      picker = 'telescope',

      lsp = {
        config = {
          name = 'zk',
          cmd = { 'zk', 'lsp' },
          filetypes = { 'markdown' },
        },
        auto_attach = {
          enabled = true,
        },
      },
    })

    -- ── Global keymaps ──────────────────────────────────────────────────
    local opts = { noremap = true, silent = false }

    -- ── Navigation ─────────────────────────────────────────────────────────────
    vim.keymap.set('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
    vim.keymap.set('n', '<leader>zt', '<Cmd>ZkTags<CR>', opts)
    vim.keymap.set(
      'n',
      '<leader>zf',
      "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
      opts
    )
    vim.keymap.set('v', '<leader>zf', ":'<,'>ZkMatch<CR>", opts)

    -- ── Create notes ───────────────────────────────────────────────────────────
    vim.keymap.set('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
    vim.keymap.set(
      'n',
      '<leader>zd',
      "<Cmd>ZkNew { dir = 'daily', template = 'daily.md', title = os.date('%Y%m%d') }<CR>",
      opts
    )
    vim.keymap.set('n', '<leader>zb', "<Cmd>ZkNew { template = 'bug.md', title = vim.fn.input('Bug: ') }<CR>", opts)
    vim.keymap.set(
      'n',
      '<leader>zl',
      "<Cmd>ZkNew { template = 'learning.md', title = vim.fn.input('Learning: ') }<CR>",
      opts
    )
    vim.keymap.set(
      'n',
      '<leader>zfe',
      "<Cmd>ZkNew { template = 'feature.md', title = vim.fn.input('Feature: ') }<CR>",
      opts
    )
    vim.keymap.set(
      'n',
      '<leader>zdc',
      "<Cmd>ZkNew { template = 'decision.md', title = vim.fn.input('Decision: ') }<CR>",
      opts
    )
    vim.keymap.set(
      'n',
      '<leader>zp',
      "<Cmd>ZkNew { template = 'permanent.md', title = vim.fn.input('Idea: ') }<CR>",
      opts
    )
  end,
}
