return {
    'nanozuki/tabby.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        require('tabby.tabline').use_preset('active_wins_at_tail', {})
    end,
}
