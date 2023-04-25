local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

ts.setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "javascript",
    "typescript",
    "graphql",
    "json",
    "css",
    "html",
    "toml",
    "yaml",
  },
  autotag = {
    enable = true,
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx", "javascriptreact", "typescript",
  "typescriptreact" }