return {
    'MeanderingProgrammer/stashpad.nvim',
    dev = vim.g.personal,
    config = function()
        require('mp.configs.stashpad')
    end,
}
