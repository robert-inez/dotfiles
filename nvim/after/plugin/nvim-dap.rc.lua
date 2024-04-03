local status, dap = pcall(require, 'dap')

local status2, dapui = pcall(require, 'dapui')

local status3, dap_go = pcall(require, 'dap-go')

local status4, dap_vt = pcall(require, 'nvim-dap-virtual-text')

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

if not status4 then
  return
end

-- Setup Go adapter using dap-go
dap_go.setup()

-- Setup Virtual Text using nvim-dap-virtual-text
dap_vt.setup()

-- Setup adapter for NodeJS using the vs-code-adapter
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

-- Setup Dap UI
dapui.setup({
  controls = {
    element = 'repl',
    enabled = true,
    icons = {
      disconnect = '',
      pause = '',
      play = '',
      run_last = '',
      step_back = '',
      step_into = '',
      step_out = '',
      step_over = '',
      terminate = '',
    },
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  force_buffers = true,
  icons = {
    collapsed = '',
    current_frame = '',
    expanded = '',
  },
  layouts = {
    {
      elements = {
        {
          id = 'scopes',
          size = 0.25,
        },
        {
          id = 'breakpoints',
          size = 0.25,
        },
        {
          id = 'stacks',
          size = 0.25,
        },
        {
          id = 'watches',
          size = 0.25,
        },
      },
      position = 'left',
      size = 40,
    },
    {
      elements = {
        {
          id = 'repl',
          size = 0.75,
        },
        {
          id = 'console',
          size = 0.25,
        },
      },
      position = 'bottom',
      size = 10,
    },
  },
  mappings = {
    edit = 'e',
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    repl = 'r',
    toggle = 't',
  },
  render = {
    indent = 1,
    max_value_lines = 100,
  },
})

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
