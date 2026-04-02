require('todo-comments').setup({
    highlight = {
        keyword = 'bg',
        pattern = [[.*<(KEYWORDS).*:]],
    },
    search = {
        pattern = [[\b(KEYWORDS).*:\s*\w]],
    },
})
