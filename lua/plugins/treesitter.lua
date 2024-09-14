local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.event = { "BufReadPost", "BufNewFile" }
Plugin.build = ":TSUpdate"

Plugin.dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
}

Plugin.config = function()
    -- Set up ts_context_commentstring
    require('ts_context_commentstring').setup {}
    vim.g.skip_ts_context_commentstring_module = true

    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "lua", "vim", "vimdoc", "query",           -- Neovim-related
            "rust", "python", "c", "cpp",              -- Common programming languages
            "javascript", "typescript", "html", "css", -- Web development
            "json", "yaml", "toml",                    -- Data formats
            "markdown", "markdown_inline",             -- Documentation
            "regex",                                   -- Useful for many languages
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = "<C-s>",
                node_decremental = "<C-backspace>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
        autotag = {
            enable = true,
        },
    })
end

return Plugin
