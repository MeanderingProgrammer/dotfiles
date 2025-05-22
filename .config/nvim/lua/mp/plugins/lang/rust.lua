return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'rust', 'toml' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = function(_, opts)
            if not vim.g.android then
                opts.install[#opts.install + 1] = 'rust-analyzer'
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
                        diagnostics = { disabled = { 'inactive-code' } },
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
