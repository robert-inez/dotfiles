return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local status, ts = pcall(require, 'nvim-treesitter.configs')
    if not status then
      return
    end

    require('nvim-treesitter.install').compilers = { 'gcc' }

    ts.setup({
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
        disable = {},
      },
      ensure_installed = {},
      auto_install = false
    })

    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.tsx.filetype_to_parsername = {
      'javascript',
      'typescript.tsx',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    }
  end,
}
