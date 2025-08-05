require('mp.globals')
require('mp.options')
require('mp.commands')
require('mp.mappings')
require('mp.diagnostics')
pcall(require, 'mp.local')

if vim.g.vscode then
    require('mp.vscode')
else
    require('mp.manager')
end
