require('lazy').setup({
  "neovim/nvim-lspconfig",           -- LSP
  "jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  "williamboman/mason.nvim",         -- Language server installer
  "williamboman/mason-lspconfig.nvim",
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  { 'echasnovski/mini.nvim', version = '*' },
  {
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
  },
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  "akinsho/nvim-bufferline.lua",
  "nvim-lualine/lualine.nvim", -- Statusline
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  'folke/tokyonight.nvim',
  "nvim-lua/plenary.nvim", -- Common utilities
  {
    'kkoomen/vim-doge',
    build = ':call doge#install()'
  },
  "norcalli/nvim-colorizer.lua",
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  "ThePrimeagen/vim-be-good", -- Vim practice...get gud
  "ThePrimeagen/harpoon",
  "numToStr/Comment.nvim",
  "lewis6991/gitsigns.nvim",
  "dinhhuy258/git.nvim",          -- For git blame & browse
  "kyazdani42/nvim-web-devicons", -- File icons
  -- Removed the following plugins in effort to use mini.nvim in all places applicable
  -- "glepnir/lspsaga.nvim", -- LSP UIs
  -- "hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
  -- "onsails/lspkind-nvim",  -- vscode-like pictograms
  -- "hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
  -- "hrsh7th/nvim-cmp") -- Completion
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- follow latest release.
  --   tag = "v<CurrentMajor>.*",
  -- })
  -- "windwp/nvim-autopairs")
  -- "github/copilot.vim")
  -- "windwp/nvim-ts-autotag")
})
