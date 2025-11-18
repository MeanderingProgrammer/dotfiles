local Keymap = require('mp.lib.keymap')

return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    dependencies = { 'nvim-mini/mini.nvim' },
    config = function()
        local harpoon = require('harpoon-core')
        harpoon.setup({
            default_action = 'vs',
        })

        Keymap.new({ prefix = '<leader>h' })
            :n('a', harpoon.add_file, 'add current file')
            :n('r', harpoon.rm_file, 'remove current file')
            :n('u', harpoon.toggle_quick_menu, 'ui toggle')
            :n('n', harpoon.nav_next, 'next file')
            :n('p', harpoon.nav_prev, 'previous file')

        for i = 1, 5 do
            Keymap.new({ prefix = '<leader>' }):n(tostring(i), function()
                harpoon.nav_file(i)
            end, ('harpoon open file %d'):format(i))
        end
    end,
}
