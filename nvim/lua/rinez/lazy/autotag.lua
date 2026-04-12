return {
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
        -- Only enable for filetypes that have parsers available
        per_filetypes = {
          ['html'] = { enable_close = true },
          ['typescript'] = { enable_close = true },
          ['typescriptreact'] = { enable_close = true },
          ['javascript'] = { enable_close = true },
          ['javascriptreact'] = { enable_close = true },
        },
      })
    end,
  },
}
