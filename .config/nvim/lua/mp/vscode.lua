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

-- undo / redo
map:n('u', '<Cmd>undo<CR>')
map:n('U', '<Cmd>redo<CR>')

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
    :n('<leader>', action('quickOpen'), 'files')
    :n('fs', action('findInFiles'))
    :n('fd', action('problems.focus'))

-- lsp
map = Keymap.new({ group = 'LSP' })
    :n('K', vim.lsp.buf.hover, 'hover')
    :n('<C-a>', vim.lsp.buf.code_action, 'code actions')
    :n('<C-r>', vim.lsp.buf.rename, 'rename')

map:extend({ prefix = 'g' })
    :n('K', vim.lsp.buf.signature_help, 'signature help')
    :n('d', vim.lsp.buf.definition, 'definitions')
    :n('i', vim.lsp.buf.implementation, 'implementations')
    :n('r', vim.lsp.buf.references, 'references')
    :n('s', vim.lsp.buf.document_symbol, 'document symbols')

map:extend({ prefix = '<leader>' })
    :n('wf', function()
        vim.print(vim.lsp.buf.list_workspace_folders())
    end, 'workspace folders')
    :n('ws', vim.lsp.buf.workspace_symbol, 'workspace symbols')
