---@param buf integer
---@return boolean
local function highlight(buf)
    local filetype = vim.bo[buf].filetype
    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
        return false
    end
    local files = vim.treesitter.query.get_files(language, 'highlights')
    return #files > 0
end

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
        languages = {},
    },
    opts_extend = { 'languages' },
    config = function(_, opts)
        ---@diagnostic disable-next-line: missing-fields
        require('nvim-treesitter.configs').setup({
            ensure_installed = opts.languages,
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-v>',
                    node_incremental = 'v',
                    node_decremental = 'V',
                    scope_incremental = false,
                },
            },
        })

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf = args.buf
                if highlight(buf) then
                    vim.treesitter.start(buf)
                end
            end,
        })
    end,
}
