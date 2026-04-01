return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        fish = { 'fish_indent' },
        go = { 'gofumpt', 'goimports', 'golines' },
        templ = { 'templ' },
        markdown = { 'prettierd' },
        python = { 'black' },
        json = { 'jq' },
        lua = { 'stylua' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        jsonc = { 'eslint_d' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })

    -- Your stylua custom args
    require('conform').formatters.stylua = {
      prepend_args = {
        '--indent-type',
        'Spaces',
        '--line-endings',
        'Unix',
        '--quote-style',
        'AutoPreferSingle',
        '--indent-width',
        vim.bo.tabstop,
      },
    }

    -- Your templ custom args
    require('conform').formatters.templ = {
      args = { 'fmt', '-stdin-filepath', '$FILENAME' },
      stdin = true,
    }
  end,
}
