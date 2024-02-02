local function n_map(name, lhs, rhs, desc)
    vim.keymap.set('n', '<leader>' .. lhs, rhs, { silent = true, desc = name .. ': ' .. desc })
end

return {
    {
        'saecki/crates.nvim',
        config = function()
            local function map(lhs, rhs, desc)
                n_map('Crates', lhs, rhs, desc)
            end
            local crates = require('crates')
            map('ct', crates.toggle, 'Toggle UI')
            map('cv', crates.show_versions_popup, 'Show Version Popup')
            map('cd', crates.show_dependencies_popup, 'Show Dependency Popup')
            map('cu', crates.upgrade_crate, 'Upgrade')
            map('cU', crates.upgrade_all_crates, 'Upgrade All')
            crates.setup({
                ---@diagnostic disable-next-line: missing-fields
                src = { cmp = { enabled = true } },
            })
        end,
    },
    {
        'MeanderingProgrammer/py-requirements.nvim',
        dev = true,
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local function map(lhs, rhs, desc)
                n_map('Requirements', lhs, rhs, desc)
            end
            local requirements = require('py-requirements')
            map('ru', requirements.upgrade, 'Upgrade')
            map('rU', requirements.upgrade_all, 'Upgrade All')
            map('rd', requirements.show_description, 'Show Description')
            requirements.setup({
                file_patterns = { '.*requirements.*.txt', '.*pyproject.*.toml' },
            })
        end,
    },
}
