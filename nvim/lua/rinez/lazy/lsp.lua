return {
  -- Mason for installing LSP servers
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
    end,
  },

  -- Bridge between mason and lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      local mason_lspconfig = require('mason-lspconfig')
      local lspconfig = require('lspconfig')

      -- Capabilities enhanced with nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Global LspAttach autocmd for all keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf, remap = false }
          local keymap = vim.keymap

          keymap.set('n', 'gd', function()
            vim.lsp.buf.definition()
          end, opts)
          keymap.set('n', 'K', function()
            vim.lsp.buf.hover()
          end, opts)
          keymap.set('n', '<leader>vd', function()
            vim.diagnostic.open_float()
          end, opts)
          keymap.set('n', '<leader>vca', function()
            vim.lsp.buf.code_action()
          end, opts)
          keymap.set('n', '<leader>vrr', function()
            vim.lsp.buf.references()
          end, opts)
          keymap.set('n', '<leader>vrn', function()
            vim.lsp.buf.rename()
          end, opts)
          keymap.set('i', '<C-h>', function()
            vim.lsp.buf.signature_help()
          end, opts)
          keymap.set('n', ']d', function()
            vim.diagnostic.jump({
              count = 1,
              wrap = true,
              on_jump = function()
                vim.diagnostic.open_float()
              end,
            })
          end, opts)
          keymap.set('n', '[d', function()
            vim.diagnostic.jump({
              count = -1,
              wrap = true,
              on_jump = function()
                vim.diagnostic.open_float()
              end,
            })
          end, opts)
        end,
      })

      mason_lspconfig.setup({
        ensure_installed = {
          'ts_ls',
          'eslint',
          'cssls',
          'gopls',
          -- 'pylsp',
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Override for lua_ls to add Neovim runtime awareness
          lua_ls = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = 'LuaJIT' },
                  workspace = {
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file('', true),
                  },
                  diagnostics = { globals = { 'vim' } },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })

      -- Diagnostic signs and display config
      vim.diagnostic.config({
        virtual_text = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
          },
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = true,
          header = '',
          prefix = '',
        },
      })

      -- Templ autocmd
      vim.api.nvim_create_autocmd('BufWritePost', {
        pattern = '*.ts',
        callback = function()
          vim.fn.system('templ generate')
        end,
      })
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = nil,
          ['<S-Tab>'] = nil,
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }),
      })
    end,
  },
}
