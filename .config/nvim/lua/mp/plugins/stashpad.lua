return {
    'MeanderingProgrammer/stashpad.nvim',
    dev = true,
    config = function()
        local stashpad = require('stashpad')
        stashpad.setup({})

        ---@param lhs string
        ---@param rhs function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('<leader>sb', stashpad.branch, 'Branch')
        map('<leader>sg', stashpad.global, 'Global')
        map('<leader>st', stashpad.todo, 'Todo')
    end,
}
