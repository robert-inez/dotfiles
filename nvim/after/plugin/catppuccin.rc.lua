local ucolors = require("catppuccin.utils.colors")
local latte = require("catppuccin.palettes").get_palette("latte")
local frappe = require("catppuccin.palettes").get_palette("frappe")
local macchiato = require("catppuccin.palettes").get_palette("macchiato")
local mocha = require("catppuccin.palettes").get_palette("mocha")

vim.g.catppuccin_flavour = "mocha"
-- vim.g.catppuccin_flavour = "macchiato"
local colors = require("catppuccin.palettes").get_palette() -- fetch colors from g:catppuccin_flavour palette
require("catppuccin").setup({
  compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
  transparent_background = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = {},
    conditionals = {},
    loops = {},
    functions = { "bold" },
    keywords = {},
    strings = {},
    variables = { "italic" },
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    cmp = true,
    telescope = true,
    treesitter = true,
    dashboard = true,
    mini = true,
    gitsigns = true,
    lsp_saga = true,
  },
  highlight_overrides = {
    all = {
      CmpBorder = { fg = "#3e4145" },
    },
    latte = {
      Normal = { fg = ucolors.darken(latte.base, 0.7, latte.mantle) },
    },
    frappe = {
      TSConstBuiltin = { fg = frappe.peach, style = {} },
      TSConstant = { fg = frappe.sky },
      TSComment = { fg = frappe.surface2, style = { "italic" } },
    },
    macchiato = {
      LineNr = { fg = macchiato.overlay1 },
      Comment = { fg = macchiato.flamingo },
    },
    mocha = {
      Comment = { fg = mocha.flamingo },
      LineNr = { fg = mocha.overlay1 },
    },
  },
  color_overrides = {
    Comment = { fg = colors.flamingo },
    TSConstBuiltin = { fg = colors.peach, style = {} },
    TSConstant = { fg = colors.sky },
    TSComment = { fg = colors.surface2, style = { "italic" } },
  },
  custom_highlights = {},
})

-- set colorscheme after options
vim.cmd("colorscheme catppuccin")
