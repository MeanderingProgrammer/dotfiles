local Keymap = require('mp.lib.keymap')
local lang = require('mp.lib.lang')
local utils = require('mp.lib.utils')

---@param buf integer
---@param id integer
local function attach(buf, id)
    local client = assert(vim.lsp.get_client_by_id(id))

    ---@param method vim.lsp.protocol.Method
    ---@return boolean
    local function supports(method)
        if vim.list_contains({ 'jdtls' }, client.name) then
            return true
        else
            return client:supports_method(method, buf)
        end
    end

    local fzf = require('fzf-lua')

    local map = Keymap.new({ buffer = buf, group = 'LSP' })
        :n('K', vim.lsp.buf.hover, 'hover')
        :n('<C-a>', vim.lsp.buf.code_action, 'code actions')
        :n('<C-r>', vim.lsp.buf.rename, 'rename')

    map:extend({ prefix = 'g' })
        :n('K', vim.lsp.buf.signature_help, 'signature help')
        :n('d', fzf.lsp_definitions, 'definitions')
        :n('i', fzf.lsp_implementations, 'implementations')
        :n('r', fzf.lsp_references, 'references')
        :n('s', fzf.lsp_document_symbols, 'document symbols')

    map:extend({ prefix = '<leader>' })
        :n('wf', function()
            vim.print(vim.lsp.buf.list_workspace_folders())
        end, 'workspace folders')
        :n('ws', fzf.lsp_workspace_symbols, 'workspace symbols')

    if supports('textDocument/codeLens') then
        map:extend({ prefix = '<leader>' })
            :n('cr', vim.lsp.codelens.run, 'codelens run')

        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd('BufWritePost', {
            buffer = buf,
            group = utils.augroup('mp.lsp.codelens', false),
            callback = vim.lsp.codelens.refresh,
        })
    end

    if supports('textDocument/documentHighlight') then
        local group = utils.augroup('mp.lsp.highlight', false)
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = buf,
            group = group,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = buf,
            group = group,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if supports('textDocument/inlayHint') then
        map:n('<leader><C-h>', function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
        end, 'inlay hints toggle')
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
            group = utils.augroup('mp.lsp'),
            callback = function(args)
                attach(args.buf, args.data.client_id)
            end,
        })
    end,
}
