function ColorMyPencils(color)
  vim.cmd.colorscheme(color)
end

return {
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    config = function()
      local status, kanagawa = pcall(require, 'kanagawa')
      if not status then
        return
      end

      kanagawa.setup({
        compile = true, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = { bold = true },
        keywordStyle = { bold = true },
        statementStyle = { bold = true },
        typeStyle = { italic = false },
        transparent = false, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = { -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors)
          return {
            -- Make functions more visible (huge for readability)
            Function = { bold = true },

            -- Improve cursor line visibility
            CursorLine = { bg = colors.palette.sumiInk1 },

            -- Slightly stronger visual separation for selections
            Visual = { bg = colors.palette.waveBlue1 },

            -- Clean up UI noise
            LineNr = { fg = colors.palette.sumiInk4 },
            CursorLineNr = { bold = true },

            -- Improve diff readability (important if you use git a lot)
            DiffAdd = { bg = colors.palette.autumnGreen },
            DiffDelete = { bg = colors.palette.autumnRed },
            DiffChange = { bg = colors.palette.springBlue },
          }
        end,
        theme = 'wave', -- Load "wave" theme
        background = { -- map the value of 'background' option to a theme
          dark = 'wave', -- try "dragon" !
          light = 'lotus',
        },
      })

      -- setup must be called before loading
      ColorMyPencils('kanagawa')
    end,
  },
}
