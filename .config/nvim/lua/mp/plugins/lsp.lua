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
            group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
            desc = 'LSP actions',
            callback = function(event)
                local builtin = require('telescope.builtin')
                require('which-key').register({
                    g = {
                        name = 'goto',
                        d = {
                            function()
                                builtin.lsp_definitions({ jump_type = 'never' })
                            end,
                            'LSP Definitions',
                        },
                        r = {
                            function()
                                builtin.lsp_references({ jump_type = 'never' })
                            end,
                            'LSP References',
                        },
                        i = {
                            function()
                                builtin.lsp_implementations({ jump_type = 'never' })
                            end,
                            'LSP Implementations',
                        },
                        s = { builtin.lsp_document_symbols, 'LSP Document Symbols' },
                    },
                    ['<leader>'] = {
                        ['k'] = { vim.lsp.buf.hover, 'LSP Hover Information' },
                        ['<C-k>'] = { vim.lsp.buf.signature_help, 'LSP Signature Help' },
                        ['<C-a>'] = { vim.lsp.buf.code_action, 'LSP Code Actions' },
                        ['<C-r>'] = { vim.lsp.buf.rename, 'LSP Rename' },
                        ['<C-h>'] = {
                            function()
                                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                                vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
                            end,
                            'LSP Toggle Inlay Hints',
                        },
                    },
                    ['<leader>w'] = {
                        name = 'workspaces',
                        s = { builtin.lsp_dynamic_workspace_symbols, 'LSP Symbols' },
                        f = {
                            function()
                                vim.print(vim.lsp.buf.list_workspace_folders())
                            end,
                            'LSP List Folders',
                        },
                    },
                }, { buffer = event.buf })

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        local capabilities = vim.tbl_deep_extend(
            'force',
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require('cmp_nvim_lsp').default_capabilities()
        )

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = vim.tbl_keys(opts.servers),
            handlers = {
                function(server_name)
                    -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                    local server = opts.servers[server_name]
                    if server then
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end
                end,
            },
        })
    end,
}
