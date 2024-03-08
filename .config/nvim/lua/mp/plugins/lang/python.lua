return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'python', 'requirements' })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua
            opts.servers.pyright = {
                root_dir = function(fname)
                    local root_files = {
                        'pyproject.toml',
                        'requirements.txt',
                        'pyrightconfig.json',
                        '.git',
                    }
                    return require('lspconfig').util.root_pattern(unpack(root_files))(fname)
                end,
            }
        end,
    },
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                python = { 'isort', 'black' },
            },
        },
    },
    {
        'MeanderingProgrammer/py-requirements.nvim',
        dev = true,
        dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
        config = function()
            local requirements = require('py-requirements')
            requirements.setup({
                file_patterns = { '.*requirements.*.txt' },
                filter = { final_release = true },
            })

            require('which-key').register({
                ['<leader>r'] = {
                    name = 'requirements',
                    u = { requirements.upgrade, 'Upgrade' },
                    U = { requirements.upgrade_all, 'Upgrade All' },
                    d = { requirements.show_description, 'Show Description' },
                },
            })
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'py-requirements' })
        end,
    },
}
