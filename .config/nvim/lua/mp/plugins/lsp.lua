local utils = require('mp.utils')

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'ibhagwan/fzf-lua',
        'williamboman/mason.nvim',
        { 'hrsh7th/cmp-nvim-lsp', optional = true },
        { 'saghen/blink.cmp', optional = true },
    },
    opts = {
        servers = {},
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
            desc = 'LSP actions',
            callback = function(args)
                ---@param lhs string
                ---@param rhs function
                ---@param desc string
                ---@param mode? string
                local function map(lhs, rhs, desc, mode)
                    vim.keymap.set(mode or 'n', lhs, rhs, { buffer = args.buf, desc = 'LSP ' .. desc })
                end
                local fzf = require('fzf-lua')
                map('gd', fzf.lsp_definitions, 'Definitions')
                map('gr', fzf.lsp_references, 'References')
                map('gi', fzf.lsp_implementations, 'Implementations')
                map('gs', fzf.lsp_document_symbols, 'Document Symbols')
                map('gS', fzf.lsp_workspace_symbols, 'Workspace Symbols')
                map('K', vim.lsp.buf.hover, 'Hover Information')
                map('<leader>k', vim.lsp.buf.signature_help, 'Signature Help')
                map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')
                map('<leader><C-a>', vim.lsp.buf.code_action, 'Code Actions')
                map('<leader><C-r>', vim.lsp.buf.rename, 'Rename')
                map('<leader><C-h>', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }))
                end, 'Toggle Inlay Hints')
                map('<leader>ws', function()
                    vim.print(vim.lsp.buf.list_workspace_folders())
                end, 'Folders')

                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = args.buf,
                        callback = vim.lsp.buf.document_highlight,
                    })
                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = args.buf,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end,
        })

        -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        for name, server in pairs(opts.servers) do
            if server then
                server.capabilities = utils.capabilities(server.capabilities)
                require('lspconfig')[name].setup(server)
            end
        end
    end,
}
