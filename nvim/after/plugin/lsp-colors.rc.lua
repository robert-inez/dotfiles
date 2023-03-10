local status, colors = pcall(require, "lsp-colors")
if (not status) then return end

colors.setup {
  Error = "#f38ba8",
  Warning = "#fab387",
  Information = "#89b4fa",
  Hint = "#94e2d5 	"
}
