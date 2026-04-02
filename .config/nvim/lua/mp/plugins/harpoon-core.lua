return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = vim.g.personal,
    dependencies = { 'nvim-mini/mini.nvim' },
    config = function()
        require('mp.configs.harpoon-core')
    end,
}
