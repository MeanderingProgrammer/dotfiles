return {
    dir = '~/dev/repos/dashboard.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('dashboard').setup({
            directories = {
                '~/.config/nvim',
                '~/dev/repos/dashboard.nvim',
                '~/dev/repos/chess',
                '~/dev/repos/advent-of-code',
                '~/dev/repos/learning',
            },
        })
    end,
}
