require('mp.config')

if vim.g.vscode then
    require('mp.vscode')
else
    require('mp.manager')
end
