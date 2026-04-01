return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
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

    local status7, hipatterns = pcall(require, 'mini.hipatterns')
    if not status7 then
      return
    end
    local status8, ai = pcall(require, 'mini.ai')
    if not status8 then
      return
    end

    pair.setup()
    surround.setup()
    bracketed.setup()
    statusline.setup()
    comment.setup()
    fuzzy.setup()
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()INFO()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
    ai.setup()
  end,
}
