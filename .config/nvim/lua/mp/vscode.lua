local Keymap = require('mp.keymap')

local map = Keymap.new({ silent = true })

---@param name string
---@return fun()
local function action(name)
    local cmd = ('workbench.action.%s'):format(name)
    return function()
        require('vscode').call(cmd)
    end
end

map:n('<C-h>', action('navigateLeft'))
map:n('<C-j>', action('navigateDown'))
map:n('<C-k>', action('navigateUp'))
map:n('<C-l>', action('navigateRight'))

map:n('<C-v>', action('splitEditorRight'))
map:n('<C-x>', action('splitEditorDown'))

map:n('<leader><leader>', action('quickOpen'))
map:n('<leader>fs', action('findInFiles'))
map:n('<leader>fd', action('problems.focus'))

map:n('gd', vim.lsp.buf.definition)
map:n('gr', vim.lsp.buf.references)
map:n('gi', vim.lsp.buf.implementation)
map:n('gs', vim.lsp.buf.document_symbol)
map:n('gS', vim.lsp.buf.workspace_symbol)
map:n('K', vim.lsp.buf.hover)
map:n('<leader>k', vim.lsp.buf.signature_help)
map:n('<leader><C-a>', vim.lsp.buf.code_action)
map:n('<leader><C-r>', vim.lsp.buf.rename)
map:n('<leader>ws', function()
    vim.print(vim.lsp.buf.list_workspace_folders())
end)
