local plugins = {
  -- Treesitter/ LSP / Formatting / Undotree
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
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
  { 'mhartington/formatter.nvim' },
  { 'mbbill/undotree' },

  -- Telescope
  { 'nvim-telescope/telescope.nvim' },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },

  -- Git
  { 'lewis6991/gitsigns.nvim' },

  -- Naviagation
  { 'ThePrimeagen/harpoon' },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  -- Nice to haves
  { 'windwp/nvim-ts-autotag' },
  { 'kyazdani42/nvim-web-devicons' }, -- File icons
  {
    'echasnovski/mini.nvim',
    version = '*',
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  { 'norcalli/nvim-colorizer.lua' },
  -- INFO: Removing as I don't use often
  -- { 'ThePrimeagen/vim-be-good' },

  --Themes
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   priority = 1000,
  -- },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
  },
  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
}
local opts = {}
require('lazy').setup(plugins, opts)
