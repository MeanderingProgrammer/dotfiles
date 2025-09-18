local Keymap = require('mp.lib.keymap')

return {
    'MeanderingProgrammer/py-requirements.nvim',
    dev = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local py = require('py-requirements')
        py.setup({
            file_patterns = { '.*requirements.*.txt' },
            filter = { final_release = true },
        })

        Keymap.new({ prefix = '<leader>r' })
            :n('d', py.show_description, 'show description')
            :n('u', py.upgrade, 'upgrade')
            :n('U', py.upgrade_all, 'upgrade all')
    end,
}
