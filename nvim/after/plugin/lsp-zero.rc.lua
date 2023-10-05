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

local keymap = vim.keymap

local lsp = lspzero.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
	'graphql',
	'marksman',
  'rust_analyzer'
})

-- Fix Undefined global 'vim'
-- lsp.configure('lua-language-server', {
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { 'vim' },
--       },
--     },
--   },
-- })

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
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
  keymap.set('n', 'K', function()
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

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.eslint.setup({})
lspconfig.graphql.setup({})
lspconfig.tsserver.setup({})
lspconfig.marksman.setup({})


lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
