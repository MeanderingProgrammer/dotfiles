local Keymap = require('mp.keymap')

return {
    'MeanderingProgrammer/harpoon-core.nvim',
    dev = true,
    dependencies = { 'echasnovski/mini.nvim' },
    config = function()
        local harpoon = require('harpoon-core')
        harpoon.setup({
            default_action = 'vs',
        })

        local map = Keymap.new({ prefix = '<leader>' })
            :n('ha', harpoon.add_file, 'add current file')
            :n('hr', harpoon.rm_file, 'remove current file')
            :n('hu', harpoon.toggle_quick_menu, 'toggle UI')
            :n('hn', harpoon.nav_next, 'next file')
            :n('hp', harpoon.nav_prev, 'previous file')
        for i = 1, 5 do
            map:n(tostring(i), function()
                harpoon.nav_file(i)
            end, ('harpoon open file %d'):format(i))
        end
    end,
}
