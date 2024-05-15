return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'rust', 'toml' })
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
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            local crates = require('crates')
            crates.setup({
                completion = {
                    cmp = { enabled = true },
                },
            })

            require('which-key').register({
                ['<leader>c'] = {
                    name = 'crates',
                    t = { crates.toggle, 'Toggle UI' },
                    v = { crates.show_versions_popup, 'Show Version Popup' },
                    d = { crates.show_dependencies_popup, 'Show Dependency Popup' },
                    u = { crates.upgrade_crate, 'Upgrade' },
                    U = { crates.upgrade_all_crates, 'Upgrade All' },
                },
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'crates' })
        end,
    },
}
