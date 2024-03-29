return {
    'folke/trouble.nvim',
    branch = 'dev',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('trouble').setup({
            -- Add width parameter to debug
            width = 200,
        })
        require('which-key').register({
            ['<leader>x'] = {
                name = 'trouble',
                l = { '<cmd>Trouble loclist toggle<cr>', 'Location List' },
                q = { '<cmd>Trouble qflist toggle<cr>', 'Quickfix List' },
                s = { '<cmd>Trouble symbols toggle focus=false<cr>', 'Symbols' },
                x = { '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics' },
                X = { '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics' },
            },
        })
    end,
}
