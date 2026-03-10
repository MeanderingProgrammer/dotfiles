return {
    'MeanderingProgrammer/py-requirements.nvim',
    dev = vim.g.personal,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('py-requirements').setup({
            filter = { final_release = true },
        })
    end,
}
