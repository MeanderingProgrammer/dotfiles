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
                local buf = event.buf
                local builtin = require('telescope.builtin')
                local jump_opts = { jump_type = 'never' }
                local map = require('mp.config.utils').map

                map('gd', builtin.lsp_definitions, 'LSP: Goto Definitions', buf, jump_opts)
                map('gr', builtin.lsp_references, 'LSP: Goto References', buf, jump_opts)
                map('gi', builtin.lsp_implementations, 'LSP: Goto Implementations', buf, jump_opts)
                map('<leader>k', vim.lsp.buf.hover, 'LSP: Hover Information', buf)
                map('<leader><C-k>', vim.lsp.buf.signature_help, 'LSP: Signature Help', buf)
                map('<leader>ca', vim.lsp.buf.code_action, 'LSP: Code Actions', buf)
                map('<leader>rn', vim.lsp.buf.rename, 'LSP: Rename', buf)
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
