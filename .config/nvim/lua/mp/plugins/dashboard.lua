local utils = require('mp.lib.utils')

---@return string[]
local function git_directories()
    ---@type string[]
    local cmd = { 'find', vim.fs.normalize('~/dev/repos/personal') }
    vim.list_extend(cmd, { '-type', 'd', '-name', '.git', '-maxdepth', '2' })
    local result = {} ---@type string[]
    local paths = utils.split(utils.system(cmd), '\n')
    for _, path in ipairs(paths) do
        result[#result + 1] = vim.fn.fnamemodify(path, ':~:h')
    end
    table.sort(result)
    return result
end

return {
    'MeanderingProgrammer/dashboard.nvim',
    dev = true,
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
                git_directories,
            },
            footer = { 'version', 'startuptime' },
        })
    end,
}
