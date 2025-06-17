---@alias mp.lsp.Config table<string, vim.lsp.Config>

---@param args vim.api.keyset.create_autocmd.callback_args
local function attach(args)
    ---@param mode string
    ---@param lhs string
    ---@param rhs function
    ---@param desc string
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
            buffer = args.buf,
            desc = 'LSP ' .. desc,
        })
    end
    local fzf = require('fzf-lua')
    map('n', 'gd', fzf.lsp_definitions, 'definitions')
    map('n', 'gr', fzf.lsp_references, 'references')
    map('n', 'gi', fzf.lsp_implementations, 'implementations')
    map('n', 'gs', fzf.lsp_document_symbols, 'document symbols')
    map('n', 'K', vim.lsp.buf.hover, 'hover information')
    map('n', '<leader>k', vim.lsp.buf.signature_help, 'signature help')
    map('i', '<C-k>', vim.lsp.buf.signature_help, 'signature help')
    map('n', '<leader><C-a>', vim.lsp.buf.code_action, 'code actions')
    map('n', '<leader><C-r>', vim.lsp.buf.rename, 'rename')
    map('n', '<leader><C-h>', function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
        vim.lsp.inlay_hint.enable(not enabled)
    end, 'toggle inlay hints')
    map('n', '<leader>ws', fzf.lsp_workspace_symbols, 'workspace symbols')
    map('n', '<leader>wf', function()
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
        'mason-org/mason.nvim',
        { 'hrsh7th/cmp-nvim-lsp', optional = true },
    },
    ---@type mp.lsp.Config
    opts = {},
    ---@param opts mp.lsp.Config
    config = function(_, opts)
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        for name, config in pairs(opts) do
            config.capabilities = require('mp.util').lsp.capabilities()
            vim.lsp.config(name, config)
            local cmd = vim.lsp.config[name].cmd[1]
            if vim.fn.executable(cmd) == 1 then
                vim.lsp.enable(name)
            end
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('user.lsp', {}),
            desc = 'LSP actions',
            callback = attach,
        })
    end,
}
