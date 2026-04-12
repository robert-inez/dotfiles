-- Patch vim.treesitter.start to guard against broken lua queries
-- Workaround for nixpkgs nvim 0.12.1 lua query bug
local orig_ts_start = vim.treesitter.start
vim.treesitter.start = function(bufnr, lang)
  local ok, err = pcall(orig_ts_start, bufnr, lang)
  if not ok then
    vim.notify(
      'treesitter: skipping ' .. (lang or '?') .. ': ' .. err,
      vim.log.levels.DEBUG
    )
  end
end
