require('lazy').setup({
  'neovim/nvim-lspconfig', -- LSP
  'mhartington/formatter.nvim',
  'williamboman/mason.nvim', -- Language server installer
  'williamboman/mason-lspconfig.nvim',
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  'nvim-lua/plenary.nvim', -- Common utilities
  'norcalli/nvim-colorizer.lua',
  'nvim-telescope/telescope.nvim',
  'windwp/nvim-ts-autotag',
  'ThePrimeagen/harpoon',
  'lewis6991/gitsigns.nvim',
  'dinhhuy258/git.nvim', -- For git blame & browse
  'kyazdani42/nvim-web-devicons', -- File icons
  {
    'echasnovski/mini.nvim',
    version = '*',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
})
