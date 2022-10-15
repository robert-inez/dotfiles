local status, worktree = pcall(require, "git-worktree")
if not status then
	return
end

worktree.setup({
	autopush = true, -- default: false,
})
require("telescope").load_extension("git_worktree")

vim.keymap.set("n", "<leader>t", "<Cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", {})
vim.keymap.set(
	"n",
	"<leader>tn",
	"<Cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
	{}
)
