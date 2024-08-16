return {
  'ThePrimeagen/harpoon',
  config = function()
    local status, mark = pcall(require, 'harpoon.mark')
    local status2, ui = pcall(require, 'harpoon.ui')
    if not status then
      return
    end

    if not status2 then
      return
    end

    local keymap = vim.keymap

    keymap.set('n', '<leader>a', mark.add_file)
    keymap.set('n', '<C-e>', ui.toggle_quick_menu)

    -- navigate to file 1
    keymap.set({ 'n', 'v' }, '<leader>1', function()
      ui.nav_file(1)
    end) -- navigate to file 2
    keymap.set({ 'n', 'v' }, '<leader>2', function()
      ui.nav_file(2)
    end) -- navigate to file 3
    keymap.set({ 'n', 'v' }, '<leader>3', function()
      ui.nav_file(3)
    end) -- navigate to file 4
    keymap.set({ 'n', 'v' }, '<leader>4', function()
      ui.nav_file(4)
    end) -- navigate to file 5
    keymap.set({ 'n', 'v' }, '<leader>5', function()
      ui.nav_file(5)
    end) -- navigate to file 6
    keymap.set({ 'n', 'v' }, '<leader>6', function()
      ui.nav_file(6)
    end) -- navigate to file 7
    keymap.set({ 'n', 'v' }, '<leader>7', function()
      ui.nav_file(7)
    end) -- navigate to file 8
    keymap.set({ 'n', 'v' }, '<leader>8', function()
      ui.nav_file(8)
    end) -- navigate to file 9
    keymap.set({ 'n', 'v' }, '<leader>9', function()
      ui.nav_file(9)
    end)
  end,
}
