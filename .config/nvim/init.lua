local utils = require('mp.lib.utils')

utils.import('mp.core')

if vim.g.vscode then
    require('mp.vscode')
else
    require('mp.main')
end
