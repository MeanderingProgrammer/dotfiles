local Keymap = require('mp.keymap')

return {
    'MeanderingProgrammer/render-markdown.nvim',
    dev = true,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'echasnovski/mini.nvim',
    },
    config = function()
        local markdown = require('render-markdown')
        markdown.setup({
            file_types = { 'markdown', 'gitcommit' },
            html = { enabled = false },
            completions = { lsp = { enabled = true } },
        })

        Keymap.new({ prefix = '<leader>m' })
            :n('d', markdown.debug, 'debug')
            :n('t', markdown.toggle, 'toggle')
    end,
}
