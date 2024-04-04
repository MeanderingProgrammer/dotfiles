return {
    'MeanderingProgrammer/dashboard.nvim',
    dev = true,
    event = 'VimEnter',
    dependencies = {
        { 'MaximilianLloyd/ascii.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },
        { 'Shatur/neovim-session-manager' },
    },
    keys = {
        { '<leader>d', '<cmd>Dashboard<cr>', desc = 'Dashboard: open' },
    },
    config = function()
        local manager = require('session_manager')
        require('dashboard').setup({
            header = require('ascii').art.text.neovim.sharp,
            directories = {
                '~/.config',
                '~/.config/nvim',
                '~/Documents/notes',
                '~/dev/repos/personal/py-requirements.nvim',
                '~/dev/repos/personal/markdown.nvim',
                '~/dev/repos/personal/harpoon-core.nvim',
                '~/dev/repos/personal/dashboard.nvim',
                '~/dev/repos/personal/advent-of-code',
                '~/dev/repos/personal/learning',
                '~/dev/repos/personal/chess',
                '~/dev/repos/personal/resume',
            },
            footer = { 'version', 'startuptime' },
            on_load = function()
                manager.load_current_dir_session()
            end,
        })
    end,
}
