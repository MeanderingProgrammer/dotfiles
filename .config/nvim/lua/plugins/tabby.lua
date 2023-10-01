return {
    'nanozuki/tabby.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    init = function()
        vim.o.showtabline = 2
    end,
    config = function()
        require('tabby.tabline').use_preset('active_wins_at_tail', {
            nerdfont = true,
        })
    end,
}
