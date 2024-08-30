return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'python', 'requirements' },
        },
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
        'williamboman/mason.nvim',
        opts = {
            formatters = {
                python = { 'isort', 'black' },
            },
        },
    },
    {
        'MeanderingProgrammer/py-requirements.nvim',
        dev = true,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'hrsh7th/nvim-cmp',
        },
        config = function()
            local requirements = require('py-requirements')
            requirements.setup({
                file_patterns = { '.*requirements.*.txt' },
                filter = { final_release = true },
            })

            ---@param lhs string
            ---@param rhs function
            ---@param desc string
            local function map(lhs, rhs, desc)
                vim.keymap.set('n', lhs, rhs, { desc = desc })
            end
            map('<leader>rd', requirements.show_description, 'Show Description')
            map('<leader>ru', requirements.upgrade, 'Upgrade')
            map('<leader>rU', requirements.upgrade_all, 'Upgrade All')
        end,
    },
    {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'py-requirements' })
        end,
    },
}
