return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
        { '<leader>h', '<cmd>WhichKey<cr>', desc = 'WhichKey: Show UI' },
    },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
}
