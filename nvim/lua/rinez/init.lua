require('rinez.set')
require('rinez.remap')
require('rinez.lazy_init')

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local RInezGroup = augroup('RInez', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})
local keymap = vim.keymap

function R(name)
  require('plenary.reload').reload_module(name)
end

autocmd('FileType', {
  pattern = 'templ',
  callback = function()
    vim.treesitter.start()
  end,
})

autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.treesitter.start()
  end,
})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

-- ── Column width per filetype ──────────────────────────────────────────────
autocmd('FileType', {
  pattern = {
    'typescript',
    'typescriptreact',
    'javascript',
    'javascriptreact',
    'go',
    'python',
    'templ',
    'markdown',
    'json',
    'lua',
    'nix',
  },
  callback = function()
    local widths = {
      go = 100,
      python = 88, -- ruff/black default
      markdown = 80,
      json = 80,
      lua = 120,
      nix = 100,
    }

    local ft = vim.bo.filetype
    local width = widths[ft] or 100 -- default 100 for ts/js/templ

    vim.opt_local.textwidth = width
    vim.opt_local.colorcolumn = tostring(width)
    vim.opt_local.wrap = ft == 'markdown' -- wrap only for markdown
    vim.opt_local.linebreak = ft == 'markdown' -- word boundary wrap for markdown
  end,
})

vim.notify = function(msg, level, opts)
  if level == vim.log.levels.ERROR then
    vim.notify_once(debug.traceback(msg, 2), level, opts)
  end
end
