---@param args vim.api.keyset.create_autocmd.callback_args
local function attach(args)
    ---@param lhs string
    ---@param rhs function
    ---@param desc string
    ---@param mode? string
    local function map(lhs, rhs, desc, mode)
        vim.keymap.set(mode or 'n', lhs, rhs, {
            buffer = args.buf,
            desc = 'LSP ' .. desc,
        })
    end
    local fzf = require('fzf-lua')
    map('gd', fzf.lsp_definitions, 'definitions')
    map('gr', fzf.lsp_references, 'references')
    map('gi', fzf.lsp_implementations, 'implementations')
    map('gs', fzf.lsp_document_symbols, 'document symbols')
    map('K', vim.lsp.buf.hover, 'hover information')
    map('<leader>k', vim.lsp.buf.signature_help, 'signature help')
    map('<C-k>', vim.lsp.buf.signature_help, 'signature help', 'i')
    map('<leader><C-a>', vim.lsp.buf.code_action, 'code actions')
    map('<leader><C-r>', vim.lsp.buf.rename, 'rename')
    map('<leader><C-h>', function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
        vim.lsp.inlay_hint.enable(not enabled)
    end, 'toggle inlay hints')
    map('<leader>ws', fzf.lsp_workspace_symbols, 'workspace symbols')
    map('<leader>wf', function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end, 'workspace folders')

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
end

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
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            desc = 'LSP actions',
            callback = attach,
        })

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        local util = require('mp.util')
        for name, server in pairs(opts.servers) do
            if server then
                server.capabilities = util.capabilities(server.capabilities)
                require('lspconfig')[name].setup(server)
            end
        end
    end,
}
