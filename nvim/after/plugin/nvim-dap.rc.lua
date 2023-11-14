local status, dap = pcall(require, 'dap')

local status2, dapui = pcall(require, 'dapui')

local status3, dap_go = pcall(require, 'dap-go')

local keymap = vim.keymap

if not status then
  return
end

if not status2 then
  return
end

if not status3 then
  return
end

dap_go.setup()

dap.adapters['pwa-node'] = {
  type = 'server',
  host = '127.0.0.1',
  port = '8123',
  executable = {
    command = 'js-debug-adapter',
  },
}

for _, language in ipairs({ 'typescript', 'javascript' }) do
  dap.configurations[language] = {
    {
      type = 'pwa-node',
      request = 'launch',
      name = 'Launch file',
      program = '${file}',
      cwd = '${workspaceFolder}',
      runtimeExecutable = 'node',
    },
  }
end

-- dapui
dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Keymaps
keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Add breakpoint at line', noremap = true })
keymap.set('n', '<leader>dt', '<cmd> DapUiToggle <CR>', { desc = 'Add breakpoint at line', noremap = true })
keymap.set('n', '<leader>dr', '<cmd> DapContinue <CR>', { desc = 'Run or continue the debugger', noremap = true })
keymap.set('n', '<leader>dq', '<cmd> DapTerminate <CR>', { desc = 'Stop debugger', noremap = true })
