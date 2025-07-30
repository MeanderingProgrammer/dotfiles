return {
    'MeanderingProgrammer/py-requirements.nvim',
    dev = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
        local requirements = require('py-requirements')
        requirements.setup({
            file_patterns = { '.*requirements.*.txt' },
            filter = { final_release = true },
        })

        ---@param lhs string
        ---@param rhs function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('<leader>rd', requirements.show_description, 'show description')
        map('<leader>ru', requirements.upgrade, 'upgrade')
        map('<leader>rU', requirements.upgrade_all, 'upgrade all')
    end,
}
