return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    opts = {
        servers = {},
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            desc = 'LSP actions',
            callback = function(event)
                local builtin = require('telescope.builtin')
                local jump_opts = { jump_type = 'never' }
                local utils = require('mp.config.utils')

                ---@param lhs string
                ---@param rhs fun()
                ---@param desc string
                local function map(lhs, rhs, desc)
                    vim.keymap.set('n', lhs, rhs, {
                        silent = true,
                        buffer = event.buf,
                        desc = 'LSP: ' .. desc,
                    })
                end
                map('gd', utils.thunk(builtin.lsp_definitions, jump_opts), 'Goto Definitions')
                map('gr', utils.thunk(builtin.lsp_references, jump_opts), 'Goto References')
                map('gi', utils.thunk(builtin.lsp_implementations, jump_opts), 'Goto Implementations')
                map('<leader>k', vim.lsp.buf.hover, 'Hover Information')
                map('<leader><C-k>', vim.lsp.buf.signature_help, 'Signature Help')
                map('<leader>ca', vim.lsp.buf.code_action, 'Code Actions')
                map('<leader>rn', vim.lsp.buf.rename, 'Rename')
            end,
        })

        local lspconfig = require('lspconfig')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local default = { capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities) }

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = vim.tbl_keys(opts.servers),
            handlers = {
                function(server)
                    -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                    local setup = opts.servers[server]
                    if setup then
                        local server_setup = vim.tbl_deep_extend('force', default, setup)
                        lspconfig[server].setup(server_setup)
                    end
                end,
            },
        })
    end,
}
