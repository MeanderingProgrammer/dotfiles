local utils = require('mp.lib.utils')

utils.import('mp.lang')

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        local data = args.data
        if data.spec.name == 'nvim-treesitter' and data.kind == 'update' then
            assert(data.active, 'nvim-treesitter not active')
            vim.cmd('TSUpdate')
        end
    end,
})

if vim.g.opaque then
    vim.pack.add({ utils.gh('folke/tokyonight.nvim') })

    require('mp.configs.tokyonight')
else
    vim.pack.add({ utils.gh('scottmckendry/cyberdream.nvim') })

    require('mp.configs.cyberdream')
end

vim.pack.add({
    utils.gh('nvim-lua/plenary.nvim'),
    utils.gh('nvim-mini/mini.nvim'),
    utils.gh('mason-org/mason.nvim'),
    utils.gh('WhoIsSethDaniel/mason-tool-installer.nvim'),
    utils.gh('ibhagwan/fzf-lua'),
    utils.gh('stevearc/oil.nvim'),
    { src = utils.gh('saghen/blink.cmp'), version = vim.version.range('*') },
    utils.gh('nvim-treesitter/nvim-treesitter'),
    utils.gh('nvim-treesitter/nvim-treesitter-context'),
    utils.gh('nvim-treesitter/nvim-treesitter-textobjects'),
    utils.gh('tpope/vim-fugitive'),
    utils.gh('tpope/vim-sleuth'),
    utils.gh('nvim-lualine/lualine.nvim'),
    utils.gh('lukas-reineke/indent-blankline.nvim'),
    utils.gh('Saecki/crates.nvim'),
    utils.gh('folke/todo-comments.nvim'),
    utils.gh('folke/which-key.nvim'),
    utils.gh('j-hui/fidget.nvim'),
    utils.gh('stevearc/quicker.nvim'),
    utils.gh('neovim/nvim-lspconfig'),
    utils.gh('mfussenegger/nvim-jdtls'),
    utils.gh('folke/lazydev.nvim'),
    utils.gh('stevearc/conform.nvim'),
    utils.gh('mfussenegger/nvim-lint'),
    utils.gh('mfussenegger/nvim-dap'),
})

---@type string[]
local plugins = {
    'dashboard.nvim',
    'harpoon-core.nvim',
    'py-requirements.nvim',
    'render-markdown.nvim',
    'stashpad.nvim',
}
if vim.g.personal then
    local src = vim.fs.abspath('~/dev/repos/personal/plugins')
    local dst = utils.path('data', 'site', 'pack', 'local', 'opt')
    assert(utils.exists(src), ('%s: missing'):format(src))
    if not utils.exists(dst) then
        vim.fn.mkdir(vim.fs.dirname(dst), 'p')
        assert(vim.uv.fs_symlink(src, dst))
    end
    for _, plugin in ipairs(plugins) do
        vim.cmd.packadd(plugin)
    end
else
    local specs = {} ---@type string[]
    for _, plugin in ipairs(plugins) do
        specs[#specs + 1] = utils.gh('MeanderingProgrammer/' .. plugin)
    end
    vim.pack.add(specs)
end

require('mp.configs.mini')
require('mp.configs.mason')
require('mp.configs.fzf-lua')
require('mp.configs.oil')
require('mp.configs.blink')
require('mp.configs.nvim-treesitter')
require('mp.configs.nvim-treesitter-textobjects')
require('mp.configs.lualine')
require('mp.configs.indent-blankline')
require('mp.configs.crates')
require('mp.configs.todo-comments')
require('mp.configs.which-key')
require('mp.configs.fidget')
require('mp.configs.quicker')
require('mp.configs.lsp')
require('mp.configs.lazydev')
require('mp.configs.conform')
require('mp.configs.nvim-lint')
require('mp.configs.nvim-dap')
require('mp.configs.dashboard')
require('mp.configs.harpoon-core')
require('mp.configs.py-requirements')
require('mp.configs.render-markdown')
require('mp.configs.stashpad')
