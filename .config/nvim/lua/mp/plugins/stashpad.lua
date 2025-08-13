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
        map('<leader>sb', stashpad.branch, 'branch')
        map('<leader>sd', stashpad.delete, 'delete')
        map('<leader>sf', stashpad.file, 'file')
        map('<leader>sg', stashpad.global, 'global')
        map('<leader>so', function()
            require('oil').toggle_float(stashpad.project())
        end, 'toggle oil')
        map('<leader>sp', function()
            stashpad.global('personal')
        end, 'personal')
        map('<leader>st', stashpad.todo, 'todo')
    end,
}
