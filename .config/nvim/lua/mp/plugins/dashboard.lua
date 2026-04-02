return {
    'MeanderingProgrammer/dashboard.nvim',
    dev = vim.g.personal,
    config = function()
        require('mp.configs.dashboard')
    end,
}
