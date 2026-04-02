return {
    'MeanderingProgrammer/py-requirements.nvim',
    dev = vim.g.personal,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        require('mp.configs.py-requirements')
    end,
}
