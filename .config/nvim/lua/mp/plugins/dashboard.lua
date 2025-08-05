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
                    local result = vim.system(cmd, { text = true }):wait()
                    local out = vim.trim(assert(result.stdout))
                    local paths = utils.split(out, '\n')
                    local dirs = {} ---@type string[]
                    for _, path in ipairs(paths) do
                        dirs[#dirs + 1] = vim.fn.fnamemodify(path, ':~:h')
                    end
                    table.sort(dirs)
                    return dirs
                end,
            },
            footer = { 'version', 'startuptime' },
        })
    end,
}
