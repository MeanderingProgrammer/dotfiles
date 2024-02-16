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
        config = function()
            local crates = require('crates')
            crates.setup({
                src = { cmp = { enabled = true } },
            })

            local map = require('mp.config.utils').leader_map
            map('ct', crates.toggle, 'Crates: Toggle UI')
            map('cv', crates.show_versions_popup, 'Crates: Show Version Popup')
            map('cd', crates.show_dependencies_popup, 'Crates: Show Dependency Popup')
            map('cu', crates.upgrade_crate, 'Crates: Upgrade')
            map('cU', crates.upgrade_all_crates, 'Crates: Upgrade All')
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = { 'Saecki/crates.nvim' },
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'crates' })
        end,
    },
}
