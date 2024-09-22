return {
    'MeanderingProgrammer/dashboard.nvim',
    dev = true,
    event = 'VimEnter',
    dependencies = { 'Shatur/neovim-session-manager' },
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
                    local directory = '~/dev/repos/personal'
                    local find_command = string.format('find %s -type d -name ".git" -maxdepth 2', directory)
                    local cleanded_command = find_command .. ' | sort | xargs dirname | sed "s|$HOME|~|g"'
                    local git_directories = vim.fn.system(cleanded_command)
                    return vim.split(vim.trim(git_directories), '\n', { plain = true })
                end,
            },
            footer = { 'version', 'startuptime' },
            on_load = function()
                require('session_manager').load_current_dir_session()
            end,
        })
    end,
}
