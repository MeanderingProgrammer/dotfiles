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
        local lspconfig = require('lspconfig')

        local cmp_capabilites = require('cmp_nvim_lsp').default_capabilities()
        local lsp_defaults = lspconfig.util.default_config
        lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, cmp_capabilites)

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

        local ensure_installed = {}
        for server in pairs(opts.servers) do
            table.insert(ensure_installed, server)
        end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = ensure_installed,
            handlers = {
                function(server)
                    -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                    local setup = opts.servers[server]
                    if setup then
                        lspconfig[server].setup(setup)
                    end
                end,
            },
        })
    end,
}
