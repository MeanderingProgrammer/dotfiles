local utils = require('mp.utils')

return {
    'MeanderingProgrammer/dashboard.nvim',
    dev = true,
    event = 'VimEnter',
    config = function()
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
                ---@return string[]
                function()
                    local root = vim.fs.normalize('~/dev/repos/personal')
                    -- stylua: ignore
                    local cmd = { 'find', root, '-type', 'd', '-name', '.git', '-maxdepth', '2' }
                    local out = utils.execute(cmd)
                    local result = {} ---@type string[]
                    for _, path in ipairs(utils.split(out, '\n', true)) do
                        result[#result + 1] = vim.fn.fnamemodify(path, ':~:h')
                    end
                    table.sort(result)
                    return result
                end,
            },
            footer = { 'version', 'startuptime' },
        })
    end,
}
