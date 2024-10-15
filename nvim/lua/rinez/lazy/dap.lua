local js_based_languages = {
  'typescript',
  'javascript',
  'typescriptreact',
  'javascriptreact',
}

return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')

      dap.defaults.js.exception_breakpoints = { 'Notice', 'Warning', 'Error', 'Exception' }
      dap.defaults.ts.exception_breakpoints = { 'Notice', 'Warning', 'Error', 'Exception' }

      -- Set up DAP configurations for JavaScript-based languages
      for _, language in ipairs(js_based_languages) do
        dap.configurations[language] = {
          -- Debug single node.js files
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}', -- Run the currently opened file
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Attach to a running Node.js process (using input for process ID)
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = function()
              return vim.fn.input('Enter process ID: ')
            end,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          {
            type = 'pwa-chrome',
            request = 'launch',
            name = 'Launch & Debug Chrome',
            url = function()
              return vim.fn.input('Enter URL (default: http://localhost:3000): ', 'http://localhost:3000')
            end,
            webRoot = vim.fn.getcwd(),
            protocol = 'inspector',
            sourceMaps = true,
            runtimeExecutable = '/snap/bin/chromium', -- Path to Chrome executable
            userDataDir = '$HOME/chromium-profile', -- User data directory
          },
          -- {
          --   name = 'Debug with Firefox',
          --   type = 'firefox',
          --   request = 'launch',
          --   reAttach = true,
          --   url = function()
          --     return vim.fn.input('Enter URL (default: http://localhost:3000): ', 'http://localhost:3000')
          --   end,
          --   webRoot = vim.fn.getcwd(),
          --   protocol = 'inspector',
          --   sourceMaps = true,
          --   firefoxExecutable = '/snap/bin/firefox',
          --   userDataDir = '$HOME/firefox-profile', -- User data directory
          -- },
          {
            name = '----- ↓ launch.json configs ↓ -----',
            type = '',
            request = 'launch',
          },
        }
      end

      -- Find where Mason installs the Firefox Debug Adapter
      --
      -- local mason_path = vim.fn.stdpath('data') .. '/mason/packages/firefox-debug-adapter'
      --
      -- dap.adapters.firefox = {
      --   type = 'executable',
      --   command = 'node',
      --   args = { mason_path .. '/dist/adapter.bundle.js' }, -- Use the Mason path
      -- }

      -- Setup nvim-dap-ui
      dapui.setup()

      -- Automatically open DAP UI when a debugging session starts
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      -- Automatically close DAP UI when a debugging session ends
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Setup nvim-dap-virtual-text
      require('nvim-dap-virtual-text').setup()
    end,
    keys = {
      -- Debug control keybindings
      {
        '<leader>dO',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>da',
        function()
          -- Load from launch.json if it exists
          if vim.fn.filereadable('.vscode/launch.json') then
            local dap_vscode = require('dap.ext.vscode')
            dap_vscode.load_launchjs(nil, {
              ['pwa-node'] = js_based_languages,
              ['chrome'] = js_based_languages,
              ['pwa-chrome'] = js_based_languages,
              -- ['firefox'] = js_based_languages, -- Include Firefox for loading configurations
            })
          end
          require('dap').continue()
        end,
        desc = 'Run with Args',
      },
      {
        '<leader>db',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = 'Toggle DAP UI',
      },
    },
    dependencies = {
      -- DAP UI for a visual debugging interface
      'rcarriga/nvim-dap-ui',

      -- Virtual text for inline variable display
      'theHamsta/nvim-dap-virtual-text',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio', -- Add nvim-nio for nvim-dap-ui

      -- Install the vscode-js-debug adapter for JavaScript/Node.js debugging
      {
        'microsoft/vscode-js-debug',
        -- After install, build it and rename the dist directory to out
        build = 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out',
        version = '1.*',
      },
      -- Integrate nvim-dap with vscode-js-debug
      {
        'mxsdev/nvim-dap-vscode-js',
        config = function()
          require('dap-vscode-js').setup({
            debugger_path = vim.fn.resolve(vim.fn.stdpath('data') .. '/lazy/vscode-js-debug'),
            adapters = {
              'chrome',
              'pwa-node',
              'pwa-chrome',
              'pwa-msedge',
              'pwa-extensionHost',
              'node-terminal',
            },
          })
        end,
      },
      -- Enable JSON5 support for parsing launch.json
      {
        'Joakker/lua-json5',
        build = './install.sh',
      },
    },
  },
}
