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

        ---@param lhs string
        ---@param rhs function
        ---@param desc string
        local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { desc = desc })
        end
        map('<leader>ct', crates.toggle, 'toggle')
        map('<leader>cv', crates.show_versions_popup, 'versions')
        map('<leader>cd', crates.show_dependencies_popup, 'dependencies')
        map('<leader>cu', crates.upgrade_crate, 'upgrade')
        map('<leader>cU', crates.upgrade_all_crates, 'upgrade all')
    end,
}
