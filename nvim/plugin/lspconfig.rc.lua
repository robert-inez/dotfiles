local status, nvim_lsp = pcall(require, 'lspconfig')
if not status then
  return
end

local keymap = vim.keymap
local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = {
    noremap = true,
    silent = true,
  }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- keymap.set('n', '<space>f', function()
  -- 	vim.lsp.buf.format({
  -- 		async = true,
  -- 	})
  -- end, opts)
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.flow.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  filetypes = {
    'typescript',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescriptreact',
    'typescript.tsx',
  },
  cmd = {
    'typescript-language-server',
    '--stdio',
  },
  capabilities = capabilities,
})

nvim_lsp.marksman.setup({})

nvim_lsp.sourcekit.setup({
  on_attach = on_attach,
})

nvim_lsp.lua_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  },
})

nvim_lsp.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Graphql
local graphql_lsp_opts = {
  filetypes = {
    'graphql',
    'typescriptreact',
    'javascriptreact',
    'typescript',
    'javascript',
  },
}
nvim_lsp.graphql.setup(graphql_lsp_opts)

-- Diagnostic symbols in the sign column (gutter)
local signs = {
  Error = ' ',
  Warn = ' ',
  Hint = ' ',
  Info = ' ',
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    numhl = '',
  })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
  },
  update_in_insert = true,
  float = {
    source = 'always', -- Or "if_many"
  },
})
