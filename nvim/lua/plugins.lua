require('lazy').setup({
	"neovim/nvim-lspconfig",          -- LSP
	"jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	"williamboman/mason.nvim",        -- Language server installer
	"williamboman/mason-lspconfig.nvim",
	'WhoIsSethDaniel/mason-tool-installer.nvim',
	{ 'echasnovski/mini.nvim', version = '*' },
	{
		"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
	},
	"nvim-telescope/telescope.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	-- "nvim-lualine/lualine.nvim", -- Statusline
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{ 'rose-pine/neovim',      name = 'rose-pine' },
	-- 'folke/tokyonight.nvim',
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
	-- "ThePrimeagen/vim-be-good", -- Vim practice...get gud
	"ThePrimeagen/harpoon",
	"numToStr/Comment.nvim",
	"lewis6991/gitsigns.nvim",
	"dinhhuy258/git.nvim",         -- For git blame & browse
	"kyazdani42/nvim-web-devicons", -- File icons
})
