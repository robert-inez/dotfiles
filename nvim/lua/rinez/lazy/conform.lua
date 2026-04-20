return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        fish = { 'fish_indent' },
        go = { 'gofumpt', 'goimports', 'golines' },
        templ = { 'templ' },
        nix = { 'alejandra' },
        python = { 'ruff_format' },
        json = { 'jq' },
        lua = { 'stylua' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        jsonc = { 'eslint_d' },
      },

      -- Skip formatting if buffer has LSP errors — prevents formatter crashes
      -- on syntax errors in any language
      format_on_save = function(bufnr)
        local errors = vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
        if #errors > 0 then
          return nil -- skip formatting, buffer has errors
        end
        return {
          timeout_ms = 1000,
          lsp_fallback = true,
        }
      end,
    })

    -- stylua custom args
    require('conform').formatters.stylua = {
      prepend_args = {
        '--indent-type',
        'Spaces',
        '--line-endings',
        'Unix',
        '--quote-style',
        'AutoPreferSingle',
        '--indent-width',
        '2',
      },
    }

    -- templ custom args
    require('conform').formatters.templ = {
      args = { 'fmt', '-stdin-filepath', '$FILENAME' },
      stdin = true,
    }
  end,
}
