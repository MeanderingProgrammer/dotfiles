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
                '~/.config/nvim',
                '~/Documents/notes',
                '~/dev/repos/harpoon-core.nvim',
                '~/dev/repos/dashboard.nvim',
                '~/dev/repos/advent-of-code',
                '~/dev/repos/chess',
                '~/dev/repos/learning',
                '~/dev/repos/open-source/nvim-plugins/dashboard-nvim',
                '~/dev/repos/open-source/nvim-plugins/harpoon',
                '~/dev/repos/personal-resume',
                '~/dev/repos/rx-availability',
                '~/dev/repos/small-apps',
                '~/dev/repos/full-gradle-app',
            },
            footer = { 'version', 'startuptime' },
        })
    end,
}
