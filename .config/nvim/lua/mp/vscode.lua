local Keymap = require('mp.lib.keymap')

---@param name string
---@return fun()
local function action(name)
    local cmd = ('workbench.action.%s'):format(name)
    return function()
        require('vscode').call(cmd)
    end
end

local map = Keymap.new({ silent = true })

-- move between panes
map:n('<C-h>', action('navigateLeft'))
map:n('<C-j>', action('navigateDown'))
map:n('<C-k>', action('navigateUp'))
map:n('<C-l>', action('navigateRight'))

-- split below / right by default
map:n('<C-v>', action('splitEditorRight'))
map:n('<C-x>', action('splitEditorDown'))

-- finder
map:extend({ prefix = '<leader>' })
    :n('<leader>', action('quickOpen'))
    :n('fs', action('findInFiles'))
    :n('fd', action('problems.focus'))

-- lsp
map:n('K', vim.lsp.buf.hover)
map:n('<leader>k', vim.lsp.buf.signature_help)
map:n('<C-a>', vim.lsp.buf.code_action)
map:n('<C-r>', vim.lsp.buf.rename)

map:extend({ prefix = 'g' })
    :n('d', vim.lsp.buf.definition)
    :n('r', vim.lsp.buf.references)
    :n('i', vim.lsp.buf.implementation)
    :n('s', vim.lsp.buf.document_symbol)

map:extend({ prefix = '<leader>' })
    :n('ws', vim.lsp.buf.workspace_symbol)
    :n('wf', function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end)
