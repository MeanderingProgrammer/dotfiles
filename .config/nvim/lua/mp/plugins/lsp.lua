local Keymap = require('mp.keymap')

---@param args vim.api.keyset.create_autocmd.callback_args
local function attach(args)
    local fzf = require('fzf-lua')
    local map = Keymap.new({ buffer = args.buf, group = 'LSP' })
        :n('gd', fzf.lsp_definitions, 'definitions')
        :n('gr', fzf.lsp_references, 'references')
        :n('gi', fzf.lsp_implementations, 'implementations')
        :n('gs', fzf.lsp_document_symbols, 'document symbols')
        :n('K', vim.lsp.buf.hover, 'hover information')
        :n('<leader>k', vim.lsp.buf.signature_help, 'signature help')
        :i('<C-k>', vim.lsp.buf.signature_help, 'signature help')
        :n('<leader><C-a>', vim.lsp.buf.code_action, 'code actions')
        :n('<leader><C-r>', vim.lsp.buf.rename, 'rename')
        :n('<leader>ws', fzf.lsp_workspace_symbols, 'workspace symbols')
        :n('<leader>wf', function()
            vim.print(vim.lsp.buf.list_workspace_folders())
        end, 'workspace folders')

    ---@param method vim.lsp.protocol.Method
    ---@return boolean
    local function supports(method)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return false
        elseif vim.list_contains({ 'jdtls' }, client.name) then
            return true
        else
            return client:supports_method(method, args.buf)
        end
    end
    if supports('textDocument/inlayHint') then
        map:n('<leader><C-h>', function()
            local enabled = vim.lsp.inlay_hint.is_enabled()
            vim.lsp.inlay_hint.enable(not enabled)
        end, 'toggle inlay hints')
    end
    if supports('textDocument/documentHighlight') then
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
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        local configs = require('mp.lang').lsp()

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        for name, config in pairs(configs) do
            vim.lsp.config(name, config)
            local cmd = vim.lsp.config[name].cmd[1]
            if vim.fn.executable(cmd) == 1 then
                vim.lsp.enable(name)
            end
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('my.lsp', {}),
            callback = attach,
        })
    end,
}
