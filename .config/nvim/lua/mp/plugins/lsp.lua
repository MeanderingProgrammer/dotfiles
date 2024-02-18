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

                require('which-key').register({
                    g = {
                        name = 'goto',
                        d = { utils.thunk(builtin.lsp_definitions, jump_opts), 'LSP Definitions' },
                        r = { utils.thunk(builtin.lsp_references, jump_opts), 'LSP References' },
                        i = { utils.thunk(builtin.lsp_implementations, jump_opts), 'LSP Implementations' },
                    },
                    ['<leader>'] = {
                        ['k'] = { vim.lsp.buf.hover, 'LSP Hover Information' },
                        ['<C-k>'] = { vim.lsp.buf.signature_help, 'LSP Signature Help' },
                        ['<C-a>'] = { vim.lsp.buf.code_action, 'LSP Code Actions' },
                        ['<C-r>'] = { vim.lsp.buf.rename, 'LSP Rename' },
                    },
                }, { buffer = event.buf })
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
