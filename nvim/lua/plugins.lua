local plugins = {
  { 'mhartington/formatter.nvim' },
  { 'norcalli/nvim-colorizer.lua' },
  { 'nvim-telescope/telescope.nvim' },
  { 'windwp/nvim-ts-autotag' },
  { 'ThePrimeagen/harpoon' },
  { 'ThePrimeagen/vim-be-good' },
  { 'lewis6991/gitsigns.nvim' },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },
  { 'dinhhuy258/git.nvim' }, -- For git blame & browse
  { 'kyazdani42/nvim-web-devicons' }, -- File icons
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },
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
  { 'mbbill/undotree' },
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
  --Themes
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
  },
  -- {
  --   'rebelot/kanagawa.nvim',
  --   lazy = false,
  --   priority = 1000,
  -- },
  -- { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
}
local opts = {}
require('lazy').setup(plugins, opts)
