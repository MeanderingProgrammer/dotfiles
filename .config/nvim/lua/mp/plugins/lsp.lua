return {
    'neovim/nvim-lspconfig',
    enabled = not require('mp.utils').is_termux,
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
                ---@param lhs string
                ---@param rhs function
                ---@param desc string
                local function map(lhs, rhs, desc)
                    vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = 'LSP ' .. desc })
                end
                local builtin = require('telescope.builtin')
                map('gd', builtin.lsp_definitions, 'Definitions')
                map('gr', builtin.lsp_references, 'References')
                map('gi', builtin.lsp_implementations, 'Implementations')
                map('gs', builtin.lsp_document_symbols, 'Document Symbols')
                map('<leader>k', vim.lsp.buf.hover, 'Hover Information')
                map('<leader><C-k>', vim.lsp.buf.signature_help, 'Signature Help')
                map('<leader><C-a>', vim.lsp.buf.code_action, 'Code Actions')
                map('<leader><C-r>', vim.lsp.buf.rename, 'Rename')
                map('<leader><C-h>', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                end, 'LSP Toggle Inlay Hints')
                map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, 'Symbols')
                map('<leader>wf', function()
                    vim.print(vim.lsp.buf.list_workspace_folders())
                end, 'List Folders')

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
