local status, kanagawa = pcall(require, 'kanagawa')
if not status then
  return
end

-- Default options:
kanagawa.setup({
  compile = true, -- enable compiling the colorscheme
  undercurl = true, -- enable undercurls
  commentStyle = { italic = true },
  functionStyle = {},
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = { bold = true },
  transparent = false, -- do not set background color
  dimInactive = true, -- dim inactive window `:h hl-NormalNC`
  terminalColors = true, -- define vim.g.terminal_color_{0,17}
  colors = { -- add/modify theme and palette colors
    palette = {},
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  },
  overrides = function(colors) -- add/modify highlights
    local theme = colors.theme
    return {
      MiniStatuslineModeNormal = { bg = colors.palette.crystalBlue, fg = colors.palette.sumiInk1 },
      MiniStatuslineModeInsert = { bg = colors.palette.waveRed, fg = colors.palette.sumiInk1 },
      MiniStatuslineModeVisual = { bg = colors.palette.oniViolet, fg = colors.palette.sumiInk1 },
      MiniStatuslineModeCommand = { bg = colors.palette.surimiOrange, fg = colors.palette.sumiInk1 },
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      -- TelescopeTitle = { fg = theme.ui.special, bold = true },
      -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    }
  end,
  theme = 'wave', -- Load "wave" theme when 'background' option is not set
  background = { -- map the value of 'background' option to a theme
    dark = 'wave', -- try "dragon" !
    light = 'lotus',
  },
})

-- setup must be called before loading
-- vim.cmd('colorscheme kanagawa-wave')
