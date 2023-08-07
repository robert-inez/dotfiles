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

keymap.set({ 'n', 'v' }, '<leader>1', function()
  ui.nav_file(1)
end) -- navigate to file 1
keymap.set({ 'n', 'v' }, '<leader>2', function()
  ui.nav_file(2)
end) -- navigate to file 2
keymap.set({ 'n', 'v' }, '<leader>3', function()
  ui.nav_file(3)
end) -- navigate to file 3
keymap.set({ 'n', 'v' }, '<leader>4', function()
  ui.nav_file(4)
end) -- navigate to file 4
