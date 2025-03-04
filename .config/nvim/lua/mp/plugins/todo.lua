return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('todo-comments').setup({
            highlight = {
                keyword = 'bg',
                pattern = [[.*<(KEYWORDS).*:]],
            },
            search = {
                pattern = [[\b(KEYWORDS).*:\s*\w]],
            },
        })
    end,
}
