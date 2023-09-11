return {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('dashboard').setup({
            config = {
                week_header = { enable = true },
            },
        })
    end,
}
