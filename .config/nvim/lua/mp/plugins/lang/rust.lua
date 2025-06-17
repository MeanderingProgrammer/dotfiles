return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'rust', 'toml' },
        },
    },
    {
        'mason-org/mason.nvim',
        ---@type mp.mason.Config
        opts = {
            ['rust-analyzer'] = { install = vim.g.computer },
        },
    },
    {
        'neovim/nvim-lspconfig',
        ---@type mp.lsp.Config
        opts = {
            rust_analyzer = {
                settings = {
                    ['rust-analyzer'] = {
                        check = { command = 'clippy' },
                        diagnostics = { disabled = { 'inactive-code' } },
                    },
                },
            },
        },
    },
    {
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
            map('<leader>ct', crates.toggle, 'Toggle UI')
            map('<leader>cv', crates.show_versions_popup, 'Versions')
            map('<leader>cd', crates.show_dependencies_popup, 'Dependencies')
            map('<leader>cu', crates.upgrade_crate, 'Upgrade')
            map('<leader>cU', crates.upgrade_all_crates, 'Upgrade All')
        end,
    },
}
