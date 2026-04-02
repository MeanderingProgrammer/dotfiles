local langs = require('mp.lib.langs')
local utils = require('mp.lib.utils')

---@param buf integer
---@param filetype string
local function attach(buf, filetype)
    local language = assert(vim.treesitter.language.get_lang(filetype))
    if not vim.treesitter.language.add(language) then
        return
    end
    vim.treesitter.start(buf, language)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { 'mason-org/mason.nvim' },
    config = function()
        local configs = langs.parsers()

        for name, config in pairs(configs) do
            local filetypes = config.filetypes
            if filetypes then
                vim.treesitter.language.register(name, filetypes)
            end
        end

        require('nvim-treesitter').setup({})
        require('nvim-treesitter').install(vim.tbl_keys(configs))

        vim.api.nvim_create_autocmd('FileType', {
            group = utils.augroup('ts.highlight'),
            callback = function(args)
                attach(args.buf, args.match)
            end,
        })
    end,
}
