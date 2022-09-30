local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

bufferline.setup({
  options = {
    mode = "tabs",
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
})

vim.keymap.set('n', 'L', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', 'H', '<Cmd>BufferLineCyclePrev<CR>', {})
