local status, telescope = pcall(require, 'telescope')
if not status then
    return
end

local status2, fuzzy = pcall(require, 'mini.fuzzy')
if not status2 then
    return
end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

local function telescope_buffer_dir()
    return vim.fn.expand('%:p:h')
end

-- local fb_actions = require('telescope').extensions.file_browser.actions

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ['q'] = actions.close,
            },
        },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
        },
        generic_sorter = fuzzy.get_telescope_sorter,
    },
    pickers = {
        -- file_browser = {
        --     hidden = true,
        --     theme = 'ivy',
        -- },
        find_files = {
            hidden = true,
            theme = 'ivy',
        },
        buffers = {
            theme = 'ivy',
        },
        oldfiles = {
            theme = 'ivy',
            hidden = true,
        },
        grep_string = {
            hidden = true,
            theme = 'ivy',
        },
        diagnostics = {
            hidden = true,
            theme = 'ivy',
        },
        implementations = {
            hidden = true,
            theme = 'ivy',
        },
        definitions = {
            hidden = true,
            theme = 'ivy',
        },
        git_status = {
            hidden = true,
            theme = 'ivy',
        },
    },
    extensions = {
        -- file_browser = {
        --     theme = 'ivy',
        --     hidden = true,
        --     -- theme = "dropdown",
        --     -- disables netrw and use telescope-file-browser in its place
        --     hijack_netrw = true,
        --     mappings = {
        --         -- your custom insert mode mappings
        --         ['i'] = {
        --             ['<C-w>'] = function()
        --                 vim.cmd('normal vbd')
        --             end,
        --         },
        --         ['n'] = {
        --             -- your custom normal mode mappings
        --             ['N'] = fb_actions.create,
        --             ['h'] = fb_actions.goto_parent_dir,
        --             ['/'] = function()
        --                 vim.cmd('startinsert')
        --             end,
        --         },
        --     },
        -- },
    },
})

-- telescope.load_extension('file_browser')

vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({
        hidden = true,
    })
end)
vim.keymap.set('n', '<leader>rf', function()
    builtin.oldfiles({
        hidden = true,
    })
end)
vim.keymap.set('n', '<leader>gs', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)
vim.keymap.set('n', '<leader>b', function()
    builtin.buffers()
end)
vim.keymap.set('n', ';;', function()
    builtin.resume()
end)
vim.keymap.set('n', '<leader>di', function()
    builtin.diagnostics()
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
-- vim.keymap.set('n', '<leader>sf', function()
--     telescope.extensions.file_browser.file_browser({
--         path = '%:p:h',
--         cwd = telescope_buffer_dir(),
--         respect_gitignore = false,
--         hidden = true,
--         grouped = true,
--         initial_mode = 'normal',
--     })
-- end)
