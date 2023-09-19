return {
    dir = '~/dev/repos/dashboard.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('dashboard').setup({
            directories = {
                '~/.config',
                '~/Documents/notes',
                '~/dev/repos/dashboard.nvim',
                '~/dev/repos/chess',
                '~/dev/repos/advent-of-code',
                '~/dev/repos/learning',
                '~/dev/repos/open-source/nvim-plugins/dashboard-nvim',
                '~/dev/repos/open-source/nvim-plugins/harpoon',
                '~/dev/repos/personal-resume',
                '~/dev/repos/rx-availability',
                '~/dev/repos/small-apps',
                '~/dev/repos/full-gradle-app',
            },
        })
    end,
}
