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
                    -- stylua: ignore
                    local cmd = {
                        'find', vim.fs.normalize('~/dev/repos/personal'),
                        '-type', 'd', '-name', '.git', '-maxdepth', '2',
                    }
                    local result = vim.system(cmd, { text = true }):wait()
                    local out = vim.trim(assert(result.stdout))
                    local lines = vim.split(out, '\n', { plain = true })

                    local dirs = {}
                    for _, line in ipairs(lines) do
                        dirs[#dirs + 1] = vim.fn.fnamemodify(line, ':~:h')
                    end
                    table.sort(dirs)
                    return dirs
                end,
            },
            footer = { 'version', 'startuptime' },
        })
    end,
}
