local Keymap = require('mp.lib.keymap')

return {
    'MeanderingProgrammer/stashpad.nvim',
    dev = true,
    config = function()
        local stashpad = require('stashpad')
        stashpad.setup({})

        Keymap.new({ prefix = '<leader>s' })
            :n('b', stashpad.branch, 'branch')
            :n('d', stashpad.delete, 'delete')
            :n('f', stashpad.file, 'file')
            :n('g', stashpad.global, 'global')
            :n('o', function()
                require('oil').toggle_float(stashpad.project())
            end, 'toggle oil')
            :n('p', function()
                stashpad.global('personal')
            end, 'personal')
            :n('t', stashpad.todo, 'todo')
    end,
}
