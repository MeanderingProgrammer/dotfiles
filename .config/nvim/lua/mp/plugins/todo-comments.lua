return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('mp.configs.todo-comments')
    end,
}
