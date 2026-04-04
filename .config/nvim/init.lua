vim.loader.enable()

require('mp.lib.utils').import('mp.core')

if vim.g.vscode then
    require('mp.vscode')
else
    require('mp.main')
    pcall(require, 'mp.local')
end
