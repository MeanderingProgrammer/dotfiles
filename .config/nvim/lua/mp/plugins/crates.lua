local Keymap = require('mp.keymap')

return {
    'Saecki/crates.nvim',
    config = function()
        local crates = require('crates')
        crates.setup({
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        })

        Keymap.new({ prefix = '<leader>c' })
            :n('t', crates.toggle, 'toggle')
            :n('v', crates.show_versions_popup, 'versions')
            :n('d', crates.show_dependencies_popup, 'dependencies')
            :n('u', crates.upgrade_crate, 'upgrade')
            :n('U', crates.upgrade_all_crates, 'upgrade all')
    end,
}
