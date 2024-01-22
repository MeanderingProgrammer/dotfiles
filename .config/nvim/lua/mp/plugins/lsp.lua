return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'folke/neodev.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        require('neodev').setup({})

        local lspconfig = require('lspconfig')

        local cmp_capabilites = require('cmp_nvim_lsp').default_capabilities()
        local lsp_defaults = lspconfig.util.default_config
        lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, cmp_capabilites)

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            desc = 'LSP actions',
            callback = function(event)
                local function map(lhs, f, opts, desc)
                    local function rhs()
                        if opts == nil then
                            f()
                        else
                            f(opts)
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

        local skip_setup = { 'jdtls' }
        local default_setup = function(server)
            if not vim.tbl_contains(skip_setup, server) then
                lspconfig[server].setup({})
            end
        end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            -- Servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            ensure_installed = {
                'bashls', -- Bash
                'csharp_ls', -- C#
                'eslint', -- ESLint
                'gopls', -- Go
                'jdtls', -- Java
                'jsonls', -- JSON
                'lua_ls', -- Lua
                'marksman', -- Markdown
                'ocamllsp', -- OCaml
                'pyright', -- Python
                'rust_analyzer', -- Rust
                'svelte', -- Svelte
                'tailwindcss', -- Tailwind
                'terraformls', -- Terraform
                'tsserver', -- TypeScript
            },
            handlers = {
                default_setup,
                bashls = function()
                    lspconfig.bashls.setup({
                        filetypes = { 'sh', 'zsh' },
                    })
                end,
                lua_ls = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                workspace = { checkThirdParty = false },
                                telemetry = { enable = false },
                            },
                        },
                    })
                end,
            },
        })
    end,
}
