local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
  use("wbthomason/packer.nvim")
  use({
    "catppuccin/nvim",
    as = "catppuccin",
  })
  use("nvim-lualine/lualine.nvim") -- Statusline
  use("nvim-lua/plenary.nvim") -- Common utilities
  use("onsails/lspkind-nvim") -- vscode-like pictograms
  use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
  use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
  use("hrsh7th/nvim-cmp") -- Completion
  use("neovim/nvim-lspconfig") -- LSP
  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v<CurrentMajor>.*",
  })
  use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use("williamboman/mason.nvim") -- Language server installer
  use("williamboman/mason-lspconfig.nvim")
  use("glepnir/lspsaga.nvim") -- LSP UIs
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })
  use("kyazdani42/nvim-web-devicons") -- File icons
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-file-browser.nvim")
  use("windwp/nvim-autopairs")
  use("norcalli/nvim-colorizer.lua")
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use("ThePrimeagen/vim-be-good") -- Vim practice...get gud
  -- use("github/copilot.vim")
  use("windwp/nvim-ts-autotag")
  use("akinsho/nvim-bufferline.lua")
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })
  use("numToStr/Comment.nvim")
  use("lewis6991/gitsigns.nvim")
  use("dinhhuy258/git.nvim") -- For git blame & browse
end)
