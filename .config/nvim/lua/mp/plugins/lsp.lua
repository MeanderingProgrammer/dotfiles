local Keymap = require('mp.lib.keymap')
local lang = require('mp.lib.lang')

---@param args vim.api.keyset.create_autocmd.callback_args
local function attach(args)
    local fzf = require('fzf-lua')
    local map = Keymap.new({ buffer = args.buf, group = 'LSP' })
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    map:n('K', vim.lsp.buf.hover, 'hover information')
    map:n('<leader>k', vim.lsp.buf.signature_help, 'signature help')
    map:i('<C-k>', vim.lsp.buf.signature_help, 'signature help')

    map:extend({ prefix = 'g' })
        :n('d', fzf.lsp_definitions, 'definitions')
        :n('r', fzf.lsp_references, 'references')
        :n('i', fzf.lsp_implementations, 'implementations')
        :n('s', fzf.lsp_document_symbols, 'document symbols')

    map:extend({ prefix = '<leader>' })
        :n('<C-a>', vim.lsp.buf.code_action, 'code actions')
        :n('<C-r>', vim.lsp.buf.rename, 'rename')
        :n('ws', fzf.lsp_workspace_symbols, 'workspace symbols')
        :n('wf', function()
            vim.print(vim.lsp.buf.list_workspace_folders())
        end, 'workspace folders')

    ---@param method vim.lsp.protocol.Method
    ---@return boolean
    local function supports(method)
        if vim.list_contains({ 'jdtls' }, client.name) then
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
    dependencies = {
        'mason-org/mason.nvim',
        'mfussenegger/nvim-jdtls',
    },
    config = function()
        local configs = lang.lsp()

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
        for name, config in pairs(configs) do
            local cmd = config.cmd
            if not cmd then
                local lsp = vim.lsp.config[name]
                cmd = type(lsp.cmd) == 'table' and lsp.cmd[1] or nil
            end
            assert(type(cmd) == 'string', ('no command for %s'):format(name))
            if vim.fn.executable(cmd) == 1 then
                vim.lsp.enable(name)
            end
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('mp.lsp', {}),
            callback = attach,
        })
    end,
}
