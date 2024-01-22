return {
    {
        'saecki/crates.nvim',
        config = function()
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', '<leader>' .. lhs, rhs, { silent = true, desc = 'Crates: ' .. desc })
            end
            local crates = require('crates')
            map('ct', crates.toggle, 'Toggle UI')
            map('cv', crates.show_versions_popup, 'Show Version Popup')
            map('cd', crates.show_dependencies_popup, 'Show Dependency Popup')
            map('cu', crates.update_all_crates, 'Update')
            map('cU', crates.upgrade_all_crates, 'Upgrade')
            crates.setup({})
        end,
    },
}
