return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    opts = {
        servers = {},
    },
    config = function(_, opts)
        local lspconfig = require('lspconfig')

        local cmp_capabilites = require('cmp_nvim_lsp').default_capabilities()
        local lsp_defaults = lspconfig.util.default_config
        lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, cmp_capabilites)

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            desc = 'LSP actions',
            callback = function(event)
                local function map(lhs, f, map_opts, desc)
                    local function rhs()
                        if map_opts == nil then
                            f()
                        else
                            f(map_opts)
                        end
                    end
                    vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end
                local builtin = require('telescope.builtin')
                map('gd', builtin.lsp_definitions, { jump_type = 'never' }, 'Goto Definitions')
                map('gr', builtin.lsp_references, { jump_type = 'never' }, 'Goto References')
                map('gi', builtin.lsp_implementations, { jump_type = 'never' }, 'Goto Implementations')
                map('<leader>k', vim.lsp.buf.hover, nil, 'Hover Information')
                map('<leader><C-k>', vim.lsp.buf.signature_help, nil, 'Signature Help')
                map('<leader>ca', vim.lsp.buf.code_action, nil, 'Code Actions')
                map('<leader>rn', vim.lsp.buf.rename, nil, 'Rename')
            end,
        })

        local ensure_installed = {}
        for server in pairs(opts.servers) do
            table.insert(ensure_installed, server)
        end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = ensure_installed,
            handlers = {
                function(server)
                    -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                    local setup = opts.servers[server]
                    if setup then
                        lspconfig[server].setup(setup)
                    end
                end,
            },
        })
    end,
}
