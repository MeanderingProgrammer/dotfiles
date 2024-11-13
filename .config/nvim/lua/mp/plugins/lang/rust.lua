local utils = require('mp.utils')

return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'rust', 'toml' },
        },
    },
    {
        'williamboman/mason.nvim',
        opts = function(_, opts)
            if not utils.is_android then
                table.insert(opts.install, 'rust-analyzer')
            end
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.rust_analyzer = {
                settings = {
                    ['rust-analyzer'] = {
                        check = { command = 'clippy' },
                    },
                },
            }
        end,
    },
    {
        'Saecki/crates.nvim',
        config = function()
            local crates = require('crates')
            crates.setup({
                completion = {
                    cmp = { enabled = true },
                },
            })

            ---@param lhs string
            ---@param rhs function
            ---@param desc string
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { desc = desc })
            end
            map('<leader>ct', crates.toggle, 'Toggle UI')
            map('<leader>cv', crates.show_versions_popup, 'Show Version Popup')
            map('<leader>cd', crates.show_dependencies_popup, 'Show Dependency Popup')
            map('<leader>cu', crates.upgrade_crate, 'Upgrade')
            map('<leader>cU', crates.upgrade_all_crates, 'Upgrade All')
        end,
    },
    {
        'saghen/blink.cmp',
        opts = {
            providers = {
                crates = { name = 'crates', module = 'blink.compat.source', score_offset = 10 },
            },
        },
    },
}
