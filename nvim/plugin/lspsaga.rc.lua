local status, saga = pcall(require, "lspsaga")
local keymap = vim.keymap
if not status then
  return
end

saga.setup({
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    cache_code_action = true,
    sign = true,
    update_time = 150,
    sign_priority = 20,
    virtual_text = true,
  },
  ui = {
    -- currently only round theme
    theme = "round",
    title = true,
    -- border type can be single,double,rounded,solid,shadow.
    border = "rounded",
    winblend = 10,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "",
    diagnostic = "",
    incoming = " ",
    outgoing = " ",
    colors = {
      --float window normal background color
      normal_bg = "#181825",
      --title background color
      title_bg = "#181825",
      red = "#f38ba8",
      magenta = "#cba6f7",
      orange = "#fab387",
      yellow = "#f9e2af",
      green = "#a6e3a1",
      cyan = "#94e2d5",
      blue = "#89b4fa",
      purple = "#b4befe",
      white = "#cdd6f4",
      black = "#11111b",
    },
    kind = {},
  },
})

local opts = { noremap = true, silent = true }
keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("n", "gj", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap.set({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", opts)
