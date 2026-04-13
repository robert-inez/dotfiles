function ColorMyPencils(color)
  vim.cmd.colorscheme(color)
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local status, catppuccin = pcall(require, 'catppuccin')
      if not status then
        return
      end

      catppuccin.setup({
        flavour = 'auto',
        background = {
          light = 'latte',
          dark = 'mocha',
        },

        -- ── Transparency ────────────────────────────────────────────────────────────
        transparent_background = false,

        float = {
          transparent = false,
          solid = true, -- matches your rounded border float style in lsp.lua
        },

        -- ── Terminal colors ──────────────────────────────────────────────────────────
        -- false: Alacritty owns the palette, avoids conflict with alacritty.toml
        term_colors = false,

        -- ── Inactive dimming ─────────────────────────────────────────────────────────
        dim_inactive = {
          enabled = true,
          shade = 'dark',
          percentage = 0.10,
        },

        no_italic = false,
        no_bold = false,
        no_underline = false,

        -- ── Syntax styles ────────────────────────────────────────────────────────────
        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          loops = {},
          functions = { 'bold' },
          keywords = { 'bold' },
          strings = {},
          variables = {},
          numbers = {},
          booleans = { 'bold' },
          properties = {},
          types = { 'bold' },
          operators = {},
        },

        -- ── LSP styles ───────────────────────────────────────────────────────────────
        -- Mirrors your vim.diagnostic.config() in lsp.lua
        lsp_styles = {
          virtual_text = {
            errors = { 'italic', 'bold' },
            hints = { 'italic' },
            warnings = { 'italic', 'bold' },
            information = { 'italic' },
            ok = {},
          },
          underlines = {
            errors = { 'undercurl' }, -- matches underline = true in lsp.lua
            hints = { 'underline' },
            warnings = { 'undercurl' },
            information = { 'underline' },
            ok = {},
          },
          inlay_hints = {
            background = true,
          },
        },

        -- ── Color overrides ──────────────────────────────────────────────────────────
        color_overrides = {
          mocha = {
            base = '#1a1a2e',
            mantle = '#141420',
            crust = '#0f0f1a',
          },
        },

        -- ── Custom highlights ────────────────────────────────────────────────────────
        custom_highlights = function(colors)
          return {
            -- Current line number bold + colored
            CursorLineNr = { fg = colors.yellow, style = { 'bold' } },

            -- Search
            Search = { bg = colors.yellow, fg = colors.base, style = { 'bold' } },
            IncSearch = { bg = colors.peach, fg = colors.base, style = { 'bold' } },

            -- Visual selection
            Visual = { bg = colors.surface2 },

            -- Oil.nvim — directory entries distinct from files
            OilDir = { fg = colors.blue, style = { 'bold' } },
            OilDirIcon = { fg = colors.blue },
            OilFile = { fg = colors.text },
            OilSocket = { fg = colors.pink },
            OilLink = { fg = colors.teal },

            -- Undotree — intentional not default
            UndotreeSavedBig = { fg = colors.green, style = { 'bold' } },
            UndotreeNode = { fg = colors.peach },
            UndotreeBranch = { fg = colors.lavender },
            UndotreeCurrent = { fg = colors.yellow, style = { 'bold' } },

            -- nvim-cmp completion menu
            CmpItemAbbrMatch = { fg = colors.blue, style = { 'bold' } },
            CmpItemAbbrMatchFuzzy = { fg = colors.sky, style = { 'bold' } },
            CmpItemKindFunction = { fg = colors.mauve },
            CmpItemKindMethod = { fg = colors.mauve },
            CmpItemKindVariable = { fg = colors.text },
            CmpItemKindKeyword = { fg = colors.red },
            CmpItemKindSnippet = { fg = colors.teal },
            CmpItemKindText = { fg = colors.subtext1 },
            CmpItemMenu = { fg = colors.subtext0, style = { 'italic' } },

            -- Telescope
            TelescopePromptBorder = { fg = colors.blue },
            TelescopeResultsBorder = { fg = colors.surface1 },
            TelescopePreviewBorder = { fg = colors.surface1 },
            TelescopeSelectionCaret = { fg = colors.peach },
            TelescopeSelection = { bg = colors.surface1 },
            TelescopeMatching = { fg = colors.blue, style = { 'bold' } },

            -- Harpoon
            HarpoonBorder = { fg = colors.lavender },
            HarpoonWindow = { bg = colors.base },

            -- Diagnostic signs matching your E W H I in lsp.lua
            DiagnosticSignError = { fg = colors.red, style = { 'bold' } },
            DiagnosticSignWarn = { fg = colors.yellow, style = { 'bold' } },
            DiagnosticSignHint = { fg = colors.teal },
            DiagnosticSignInfo = { fg = colors.sky },
          }
        end,

        -- ── Integrations ─────────────────────────────────────────────────────────────
        default_integrations = true,
        auto_integrations = false,

        integrations = {
          cmp = true,
          telescope = { enabled = true, style = 'nvchad' },
          oil = true,
          mini = {
            enabled = true,
            indentscope_color = 'lavender',
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic', 'bold' },
              hints = { 'italic' },
              warnings = { 'italic', 'bold' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'underline' },
              warnings = { 'undercurl' },
              information = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
          treesitter = true,
          treesitter_context = true,

          -- Explicitly off — not in your plugin list
          gitsigns = false,
          nvimtree = false,
          notify = false,
          which_key = false,
          indent_blankline = { enabled = false },
        },
      })

      -- setup must be called before loading
      ColorMyPencils('catppuccin')
    end,
  },
}
