local Plugin = { "neovim/nvim-lspconfig" }

Plugin.dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true },
}

Plugin.config = function()
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()

    local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end

    ---@diagnostic disable [missing-fields]
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "clangd" },
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end,

            ["lua_ls"] = function()
                require("lspconfig").lua_ls.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim", "it", "describe", "before_each", "after_each" } },
                        },
                    },
                })
            end,

            ["rust_analyzer"] = function()
                require("lspconfig").rust_analyzer.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
                            assist = { importGranularity = "module", importPrefix = "self" },
                            cargo = { loadOutDirsFromCheck = true, buildScripts = { enable = true } },
                            procMacro = { enable = true },
                            checkOnSave = { command = "clippy" },
                            inlayHints = { lifetimeElisionHints = { enable = true, useParameterNames = true } },
                            diagnostics = { enable = true, experimental = { enable = true } },
                        }
                    },
                })
            end,

            ["clangd"] = function()
                require("lspconfig").clangd.setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    cmd = { "clangd" },
                    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                    root_dir = require("lspconfig.util").root_pattern(
                        '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json',
                        'compile_flags.txt', 'configure.ac', '.git'
                    ),
                    single_file_support = true,
                })
            end
        }
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
            { name = "lazydev", group_index = 0 },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },
            { name = 'path' },
        }),
    })
end

return Plugin
