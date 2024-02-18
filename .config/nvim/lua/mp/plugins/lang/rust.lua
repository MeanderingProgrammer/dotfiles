return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'rust', 'toml' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = {
            servers = {
                rust_analyzer = {
                    settings = {
                        ['rust-analyzer'] = {
                            check = { command = 'clippy' },
                        },
                    },
                },
            },
        },
    },
    {
        'Saecki/crates.nvim',
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            local crates = require('crates')
            crates.setup({
                src = { cmp = { enabled = true } },
            })

            ---@param lhs string
            ---@param rhs fun()
            ---@param desc string
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', '<leader>' .. lhs, rhs, {
                    silent = true,
                    desc = 'Crates: ' .. desc,
                })
            end
            map('ct', crates.toggle, 'Toggle UI')
            map('cv', crates.show_versions_popup, 'Show Version Popup')
            map('cd', crates.show_dependencies_popup, 'Show Dependency Popup')
            map('cu', crates.upgrade_crate, 'Upgrade')
            map('cU', crates.upgrade_all_crates, 'Upgrade All')
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'crates' })
        end,
    },
}
