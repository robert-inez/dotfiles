local status, rose_pine = pcall(require, 'rose-pine')
if not status then
  return
end
-- Default options:
rose_pine.setup({
  --- @usage 'auto'|'main'|'moon'|'dawn'
  variant = 'auto',
  --- @usage 'main'|'moon'|'dawn'
  dark_variant = 'main',
  bold_vert_split = false,
  dim_nc_background = false,
  disable_background = false,
  disable_float_background = false,
  disable_italics = true,
  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    background = 'base',
    background_nc = '_experimental_nc',
    panel = 'surface',
    panel_nc = 'base',
    border = 'highlight_med',
    comment = 'muted',
    link = 'iris',
    punctuation = 'subtle',
    error = 'love',
    hint = 'iris',
    info = 'foam',
    warn = 'gold',
    headings = {
      h1 = 'iris',
      h2 = 'foam',
      h3 = 'rose',
      h4 = 'gold',
      h5 = 'pine',
      h6 = 'foam',
    },
    -- or set all headings at once
    -- headings = 'subtle'
  },
  -- Change specific vim highlight groups
  -- https://github.com/rose-pine/neovim/wiki/Recipes
  highlight_groups = {
    ColorColumn = { bg = 'rose' },
    -- Blend colours against the "base" background
    --
    DiagnosticUnderlineError = { undercurl = false, underline = true },
    DiagnosticUnderlineInfo = { undercurl = false, underline = true },
    DiagnosticUnderlineWarn = { undercurl = false, underline = true },
    MiniStatuslineModeNormal = { bg = 'foam', fg = 'base' },
    MiniStatuslineModeInsert = { bg = 'love', fg = 'base' },
    MiniStatuslineModeVisual = { bg = 'iris', fg = 'base' },
    MiniStatuslineModeCommand = { bg = 'gold', fg = 'base' },
  },
})

-- Set colorscheme after options
-- vim.cmd('colorscheme rose-pine')
