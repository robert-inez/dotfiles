local status, masonTool = pcall(require, 'mason-tool-installer')
if not status then
  return
end

masonTool.setup({
  ensure_installed = {
    'typescript-language-server',
    'prettierd',
    'eslint_d',
  },
})
