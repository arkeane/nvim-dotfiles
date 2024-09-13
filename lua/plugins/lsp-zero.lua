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
}

Plugin.config = function()
	local cmp = require("cmp")
	local cmp_lsp = require("cmp_nvim_lsp")
	local capabilities =
		vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

	require("fidget").setup({})
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"lua_ls",
            "pyright"
		},
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim", "it", "describe", "before_each", "after_each" },
							},
						},
					},
				})
			end,

            ["pyright"] = function ()
                local lspconfig = require("lspconfig")
                lspconfig.pyright.setup({
                    capabilities = capabilities
                })
            end,

            ["rust_analyzer"] = function()
                local lspconfig = require("lspconfig")
                local on_attach = function(client, bufnr)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                    -- Key mappings
                    local opts = { noremap=true, silent=true, buffer=bufnr }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

                    -- Format on save
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("Format", { clear = true }),
                            buffer = bufnr,
                            callback = function() vim.lsp.buf.format() end
                        })
                    end
                end

                lspconfig.rust_analyzer.setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = {
                        ["rust-analyzer"] = {
                            assist = {
                                importGranularity = "module",
                                importPrefix = "self",
                            },
                            cargo = {
                                loadOutDirsFromCheck = true,
                                buildScripts = {
                                    enable = true,
                                },
                            },
                            procMacro = {
                                enable = true
                            },
                            checkOnSave = {
                                command = "clippy"
                            },
                            inlayHints = {
                                lifetimeElisionHints = {
                                    enable = true,
                                    useParameterNames = true
                                },
                            },
                            diagnostics = {
                                enable = true,
                                experimental = {
                                    enable = true,
                                },
                            },
                        }
                    },
                    flags = {
                        debounce_text_changes = 150,
                    },
                })
            end
		},
	})

	local cmp_select = { behavior = cmp.SelectBehavior.Select }

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
		}),
	})
end

return Plugin
