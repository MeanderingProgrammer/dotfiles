return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            languages = { 'python', 'requirements' },
        },
    },
    {
        'mason-org/mason.nvim',
        opts = function(_, opts)
            opts.install[#opts.install + 1] = 'pyright'
            vim.list_extend(opts.install, { 'black', 'isort' })
            opts.formatters.python = { 'black', 'isort' }
            opts.formatter_overrides.isort = {
                prepend_args = { '--profile', 'black' },
            }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            opts.servers.pyright = {
                settings = {
                    python = {
                        analysis = {
                            diagnosticMode = 'workspace',
                        },
                    },
                },
            }
        end,
    },
    {
        'MeanderingProgrammer/py-requirements.nvim',
        dev = true,
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
}
