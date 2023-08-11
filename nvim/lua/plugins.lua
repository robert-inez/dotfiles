require('lazy').setup({
  'mhartington/formatter.nvim',
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  -- 'nvim-lua/plenary.nvim', -- Common utilities
  'norcalli/nvim-colorizer.lua',
  'nvim-telescope/telescope.nvim',
  'windwp/nvim-ts-autotag',
  'ThePrimeagen/harpoon',
  'lewis6991/gitsigns.nvim',
  'rebelot/kanagawa.nvim',
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
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { 'williamboman/mason.nvim' }, -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' }, -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' }, -- Required
    },
  },

  -- 'neovim/nvim-lspconfig', -- LSP
  -- 'williamboman/mason.nvim', -- Language server installer
  -- 'williamboman/mason-lspconfig.nvim',
  -- 'nvim-telescope/telescope-file-browser.nvim',
  -- dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  -- },
})
