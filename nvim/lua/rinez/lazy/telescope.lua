return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local status, telescope = pcall(require, 'telescope')
        if not status then
            return
        end

        local status2, fuzzy = pcall(require, 'mini.fuzzy')
        if not status2 then
            return
        end

        local actions = require('telescope.actions')

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
                find_files = {
                    hidden = true,
                },
                diagnostics = {},
                oldfiles = {
                    hidden = true,
                },
                grep_string = {
                    hidden = true,
                },
            },
            extensions = {},
        })

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>tf', function()
            builtin.find_files({
                hidden = true,
            })
        end)
        vim.keymap.set('n', '<leader>to', function()
            builtin.oldfiles({
                hidden = true,
            })
        end)
        vim.keymap.set('n', '<leader>tg', function()
            builtin.grep_string({ search = vim.fn.input('Grep > ') })
        end)
        vim.keymap.set('n', '<leader>td', function()
            builtin.diagnostics()
        end)
        vim.keymap.set('n', '<leader>;;', function()
            builtin.resume()
        end)
        vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
    end,
}
