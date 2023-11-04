local status, lspzero = pcall(require, 'lsp-zero')
if not status then
  return
end

local status2, cmp = pcall(require, 'cmp')
if not status2 then
  return
end

local status3, lspconfig = pcall(require, 'lspconfig')
if not status3 then
  return
end

local status4, mason = pcall(require, 'mason')
if not status4 then
  return
end

local status5, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status5 then
  return
end
local keymap = vim.keymap

local lsp = lspzero.preset('recommended')

mason.setup({})
mason_lspconfig.setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'graphql',
    'marksman',
    'rust_analyzer',
  },
  handlers = {
    lspzero.default_setup,
    lua_ls = function()
      local lua_opts = lspzero.nvim_lua_ls()
      lspconfig.lua_ls.setup(lua_opts)
    end,
  },
})

local cmp_format = require('lsp-zero').cmp_format()

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  }),
})

lsp.set_preferences({
  suggest_lsp_servers = false,
})

lsp.set_sign_icons({
  error = ' ',
  warn = ' ',
  hint = '󰌶 ',
  info = ' ',
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, opts)
  keymap.set('n', 'gD', function()
    vim.lsp.buf.declaration()
  end, opts)
  keymap.set('n', '<leader>K', function()
    vim.lsp.buf.hover()
  end, opts)
  keymap.set('n', '<leader>ws', function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  keymap.set('n', '<leader>vd', function()
    vim.diagnostic.open_float()
  end, opts)
  keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, opts)
  keymap.set('n', '<leader>rr', function()
    vim.lsp.buf.references()
  end, opts)
  keymap.set('n', 'gi', function()
    vim.lsp.buf.implementation()
  end, opts)
  keymap.set('n', '<leader>D', function()
    vim.lsp.buf.type_definition()
  end, opts)
  keymap.set('n', '<leader>rn', function()
    vim.lsp.buf.rename()
  end, opts)
  keymap.set('i', '<C-h>', function()
    vim.lsp.buf.signature_help()
  end, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
