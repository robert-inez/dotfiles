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
