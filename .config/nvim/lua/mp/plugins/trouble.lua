return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local mode_config = {
            focus = false,
            win = { position = 'bottom', size = 15 },
        }
        require('trouble').setup({
            modes = {
                lsp = mode_config,
                symbols = mode_config,
            },
        })
        require('which-key').register({
            ['<leader>x'] = {
                name = 'trouble',
                l = { '<cmd>Trouble lsp toggle<cr>', 'LSP' },
                s = { '<cmd>Trouble symbols toggle<cr>', 'Symbols' },
                x = { '<cmd>Trouble diagnostics toggle<cr>', 'Diagnostics' },
                X = { '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', 'Buffer Diagnostics' },
            },
        })
    end,
}
