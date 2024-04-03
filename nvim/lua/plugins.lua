local plugins = {
  -- Treesitter/ LSP / Formatting / Undotree
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  -- INFO: commenting as I am not sure I like. Might just need to adjust config
  -- { 'nvim-treesitter/nvim-treesitter-context' },
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
  { 'windwp/nvim-ts-autotag' },

  -- Telescope
  { 'nvim-telescope/telescope.nvim' },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },

  -- Debug
  -- INFO: Commenting as I do not use
  -- { 'rcarriga/nvim-dap-ui', dependencies = 'mfussenegger/nvim-dap' },
  -- { 'theHamsta/nvim-dap-virtual-text' },
  -- { 'leoluz/nvim-dap-go' },

  -- Copilot
  -- INFO: Really not a fan of some of the things this does
  -- { 'github/copilot.vim' },

  -- Git
  { 'lewis6991/gitsigns.nvim' },

  -- Navigation
  { 'ThePrimeagen/harpoon' },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  -- Nice to haves
  { 'kyazdani42/nvim-web-devicons' }, -- File icons
  {
    'echasnovski/mini.nvim',
    version = '*',
  },
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  -- { 'norcalli/nvim-colorizer.lua' },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000, lazy = false },
  -- { 'folke/tokyonight.nvim', lazy = false, priority = 1000 },
  { 'rebelot/kanagawa.nvim', priority = 1000, lazy = false },
  -- { 'rose-pine/neovim', name = 'rose-pine', priority = 1000, lazy = false },
}
local opts = {}
require('lazy').setup(plugins, opts)
