local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      theme = "ivy",
      -- theme = "dropdown",
    },
    buffers = {
      theme = "ivy",
    },
    oldfiles = {
      theme = "ivy",
      hidden = true,
      -- theme = "dropdown",
    },
    live_grep = {
      hidden = true,
      theme = "ivy",
      -- theme = "dropdown",
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd("normal vbd")
          end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")

vim.keymap.set("n", ";f", function()
  builtin.find_files({
    hidden = true,
  })
end)
vim.keymap.set("n", "rf", function()
  builtin.oldfiles({
    hidden = true,
  })
end)
vim.keymap.set("n", ";r", function()
  builtin.live_grep()
end)
vim.keymap.set("n", "fb", function()
  builtin.buffers()
end)
vim.keymap.set("n", ";t", function()
  builtin.help_tags()
end)
vim.keymap.set("n", ";;", function()
  builtin.resume()
end)
vim.keymap.set("n", ";d", function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    initial_mode = "normal",
  })
end)