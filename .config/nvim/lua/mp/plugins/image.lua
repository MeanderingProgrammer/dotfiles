return {
    'samodostal/image.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'm00qek/baleia.nvim', tag = 'v1.3.0' },
    },
    config = function()
        require('image').setup({
            render = {
                foreground_color = true,
                background_color = true,
            },
        })
    end,
}
