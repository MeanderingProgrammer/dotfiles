return {
    'MeanderingProgrammer/dashboard.nvim',
    dev = true,
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        { 'MaximilianLloyd/ascii.nvim', dependencies = { 'MunifTanjim/nui.nvim' } },
    },
    keys = {
        { '<leader>d', '<cmd>Dashboard<cr>', desc = 'Dashboard: open' },
    },
    config = function()
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
                '~/dev/repos/personal/rx-availability',
            },
            footer = { 'version', 'startuptime' },
        })
    end,
}
