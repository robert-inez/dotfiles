local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end
local status3, masonTool = pcall(require, "mason-tool-installer")
if (not status3) then return end

mason.setup({})

lspconfig.setup {
  ensure_installed = { "lua_ls", "tailwindcss" },
}
masonTool.setup({
  ensure_installed = {
    'typescript-language-server',
    'prettierd',
    'eslint_d'
  }
})
