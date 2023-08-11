vim.cmd('autocmd!')

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.backup = false
vim.opt.showcmd = true

vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.showmode = false

vim.opt.relativenumber = true
vim.opt.expandtab = false
vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 50
vim.opt.shell = 'zsh'
vim.opt.backupskip = '/tmp/*,/private/tmp/*'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.bo.tabstop = 2
vim.opt.expandtab = false

vim.opt.wrap = false --Wrap lines
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.path:append({ '**' }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ '*/node_modules/*' })

vim.g.netrw_fastbrowse = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30
vim.g.netrw_keepdir = 0
vim.g.netrw_localcopydircmd = 'cp -r'
vim.opt.nu = true

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Add asterisks in block comments
vim.opt.formatoptions:append({ 'r' })
