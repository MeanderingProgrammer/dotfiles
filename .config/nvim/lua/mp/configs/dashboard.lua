local utils = require('mp.lib.utils')

require('dashboard').setup({
    header = {
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
    },
    directories = {
        '~/.config',
        '~/.config/nvim',
        '~/Documents/notes',
        function()
            local root = vim.fs.normalize(vim.env.WORKSPACE)
            local cmd = {
                'find',
                root,
                '-type',
                'd',
                '-name',
                '.git',
                '-maxdepth',
                '2',
            }
            local result = {} ---@type string[]
            local paths = utils.split(utils.system(cmd), '\n')
            for _, path in ipairs(paths) do
                result[#result + 1] = vim.fn.fnamemodify(path, ':~:h')
            end
            table.sort(result)
            return result
        end,
    },
    footer = { 'version', 'startuptime' },
})
