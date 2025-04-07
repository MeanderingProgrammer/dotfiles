---@param lhs string
---@param rhs function
local function map(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { noremap = true, silent = true })
end

---@param command string
---@return function
local function call(command)
    return function()
        require('vscode').call(command)
    end
end

map('<C-h>', call('workbench.action.navigateLeft'))
map('<C-j>', call('workbench.action.navigateDown'))
map('<C-k>', call('workbench.action.navigateUp'))
map('<C-l>', call('workbench.action.navigateRight'))

map('<C-v>', call('workbench.action.splitEditorRight'))
map('<C-x>', call('workbench.action.splitEditorDown'))

map('<leader><leader>', call('workbench.action.quickOpen'))
map('<leader>fs', call('workbench.action.findInFiles'))
map('<leader>fd', call('workbench.action.problems.focus'))

map('gd', vim.lsp.buf.definition)
map('gr', vim.lsp.buf.references)
map('gi', vim.lsp.buf.implementation)
map('gs', vim.lsp.buf.document_symbol)
map('gS', vim.lsp.buf.workspace_symbol)
map('K', vim.lsp.buf.hover)
map('<leader>k', vim.lsp.buf.signature_help)
map('<leader><C-a>', vim.lsp.buf.code_action)
map('<leader><C-r>', vim.lsp.buf.rename)
map('<leader>ws', function()
    vim.print(vim.lsp.buf.list_workspace_folders())
end)
