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
    -- common
    utils.gh('nvim-lua/plenary.nvim'),
    utils.gh('nvim-mini/mini.nvim'),

    -- mason
    utils.gh('mason-org/mason.nvim'),
    utils.gh('WhoIsSethDaniel/mason-tool-installer.nvim'),

    -- treesitter
    utils.gh('nvim-treesitter/nvim-treesitter'),
    utils.gh('nvim-treesitter/nvim-treesitter-context'),
    utils.gh('nvim-treesitter/nvim-treesitter-textobjects'),

    -- file navigation
    utils.gh('ibhagwan/fzf-lua'),
    utils.gh('stevearc/oil.nvim'),

    -- completions
    utils.gh('saghen/blink.cmp', vim.version.range('1.*')),

    -- QoL
    utils.gh('folke/todo-comments.nvim'),
    utils.gh('folke/which-key.nvim'),
    utils.gh('j-hui/fidget.nvim'),
    utils.gh('lukas-reineke/indent-blankline.nvim'),
    utils.gh('nvim-lualine/lualine.nvim'),
    utils.gh('Saecki/crates.nvim'),
    utils.gh('stevearc/quicker.nvim'),
    utils.gh('tpope/vim-fugitive'),
    utils.gh('tpope/vim-sleuth'),

    -- lsp
    utils.gh('neovim/nvim-lspconfig'),
    utils.gh('mfussenegger/nvim-jdtls'),
    utils.gh('folke/lazydev.nvim'),

    -- dap / lint / format
    utils.gh('mfussenegger/nvim-dap'),
    utils.gh('mfussenegger/nvim-lint'),
    utils.gh('stevearc/conform.nvim'),
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
    local specs = {} ---@type vim.pack.Spec[]
    for _, plugin in ipairs(plugins) do
        specs[#specs + 1] = utils.gh('MeanderingProgrammer/' .. plugin)
    end
    vim.pack.add(specs)
end

-- common
require('mp.configs.mini')

-- mason
require('mp.configs.mason')

-- treesitter
require('mp.configs.nvim-treesitter')
require('mp.configs.nvim-treesitter-textobjects')

-- file navigation
require('mp.configs.fzf-lua')
require('mp.configs.oil')

-- completions
require('mp.configs.blink')

-- QoL
require('mp.configs.todo-comments')
require('mp.configs.which-key')
require('mp.configs.fidget')
require('mp.configs.indent-blankline')
require('mp.configs.lualine')
require('mp.configs.crates')
require('mp.configs.quicker')

-- lsp
require('mp.configs.lsp')
require('mp.configs.lazydev')

-- dap / lint / format
require('mp.configs.nvim-dap')
require('mp.configs.nvim-lint')
require('mp.configs.conform')

-- personal
require('mp.configs.dashboard')
require('mp.configs.harpoon-core')
require('mp.configs.py-requirements')
require('mp.configs.render-markdown')
require('mp.configs.stashpad')
