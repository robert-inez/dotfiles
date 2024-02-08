local status1, surround = pcall(require, 'mini.surround')
if not status1 then
  return
end

local status2, pair = pcall(require, 'mini.pairs')
if not status2 then
  return
end

local status3, bracketed = pcall(require, 'mini.bracketed')
if not status3 then
  return
end

local status4, statusline = pcall(require, 'mini.statusline')
if not status4 then
  return
end

local status5, comment = pcall(require, 'mini.comment')
if not status5 then
  return
end

local status6, fuzzy = pcall(require, 'mini.fuzzy')
if not status6 then
  return
end

local base16_catppuccin = {
  base00 = '#1e1e2e', -- base
  base01 = '#181825', -- mantle
  base02 = '#313244', -- surface0
  base03 = '#45475a', -- surface1
  base04 = '#585b70', -- surface2
  base05 = '#cdd6f4', -- text
  base06 = '#f5e0dc', -- rosewater
  base07 = '#b4befe', -- lavender
  base08 = '#f38ba8', -- red
  base09 = '#fab387', -- peach
  base0A = '#f9e2af', -- yellow
  base0B = '#a6e3a1', -- green
  base0C = '#94e2d5', -- teal
  base0D = '#89b4fa', -- blue
  base0E = '#cba6f7', -- mauve
  base0F = '#f2cdcd', -- flamingo
}

local base16_rosepine = {
  base00 = '#191724',
  base01 = '#1f1d2e',
  base02 = '#26233a',
  base03 = '#6e6a86',
  base04 = '#908caa',
  base05 = '#e0def4',
  base06 = '#e0def4',
  base07 = '#524f67',
  base08 = '#eb6f92',
  base09 = '#f6c177',
  base0A = '#ebbcba',
  base0B = '#31748f',
  base0C = '#9ccfd8',
  base0D = '#c4a7e7',
  base0E = '#f6c177',
  base0F = '#524f67',
}

local base16_kanagawa = {
  base00 = '#1f1f28',
  base01 = '#16161d',
  base02 = '#223249',
  base03 = '#54546d',
  base04 = '#727169',
  base05 = '#dcd7ba',
  base06 = '#c8c093',
  base07 = '#717c7c',
  base08 = '#c34043',
  base09 = '#ffa066',
  base0A = '#c0a36e',
  base0B = '#76946a',
  base0C = '#6a9589',
  base0D = '#7e9cd8',
  base0E = '#957fb8',
  base0F = '#d27e99',
}

-- base16.setup({
--   palette = base16_catppuccin,
--   use_cterm = true,
--   plugins = {
--     default = true,
--     ['echasnovski/mini.nvim'] = true,
--   },
-- })

pair.setup()
surround.setup()
bracketed.setup()
statusline.setup()
comment.setup()
fuzzy.setup()
