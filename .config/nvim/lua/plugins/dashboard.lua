return {
    dir = '~/dev/repos/dashboard.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('dashboard').setup()
    end,
}
