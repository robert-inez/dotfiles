local status, pomodoro = pcall(require, "pomodoro")
if not status then
	return
end

pomodoro.setup()
vim.keymap.set("n", "<leader>pt", "<Cmd>PomodoroStart<CR>")
vim.keymap.set("n", "<leader>pe", "<Cmd>PomodoroStop<CR>")
