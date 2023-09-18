return {
    dir = '~/dev/repos/dashboard.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('dashboard').setup({
            directories = {
                '~/dev/repos/advent-of-code',
                '~/dev/repos/chess',
                '~/dev/repos/dashboard.nvim',
                '~/dev/repos/learning',
            },
        })
    end,
}
