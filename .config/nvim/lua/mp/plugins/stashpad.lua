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
        map('<leader>sd', stashpad.delete, 'Delete')
        map('<leader>sf', stashpad.file, 'File')
        map('<leader>sg', stashpad.global, 'Global')
        map('<leader>so', function()
            require('oil').toggle_float(stashpad.project())
        end, 'Oil Toggle')
        map('<leader>st', stashpad.todo, 'Todo')
    end,
}
