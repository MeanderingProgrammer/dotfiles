return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = function()
        require('noice').setup({
            lsp = {
                progress = { enabled = false },
            },
        })
    end,
}
