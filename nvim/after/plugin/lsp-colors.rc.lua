local status, colors = pcall(require, "lsp-colors")
if (not status) then return end

colors.setup {
  Error = "#ed8796",
  Warning = "#f5a97f",
  Information = "#8aadf4",
  Hint = "#8bd5ca"
}
