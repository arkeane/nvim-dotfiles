local Plugin = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate"
}

Plugin.event = { "BufReadPost", "BufNewFile" }

Plugin.dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    "windwp/nvim-ts-autotag",
    "JoosepAlviste/nvim-ts-context-commentstring",
}

Plugin.init = function()
    vim.g.skip_ts_context_commentstring_module = true
end

Plugin.config = function()
    require('ts_context_commentstring').setup {}
    require('nvim-ts-autotag').setup {}

    require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "query",
        "rust", "python", "c", "cpp",
        "javascript", "typescript", "html", "css",
        "json", "yaml", "toml",
        "markdown", "markdown_inline",
        "regex",
    })

    vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
        callback = function(event)
            local lang = vim.treesitter.language.get_lang(event.match) or event.match

            if vim.treesitter.query.get(lang, "highlights") then
                vim.treesitter.start(event.buf, lang)
            end

            if vim.treesitter.query.get(lang, "indents") then
                vim.bo[event.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            end

            if vim.treesitter.query.get(lang, "folds") then
                vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo.foldmethod = "expr"
                vim.wo.foldenable = false
            end
        end,
    })

    require("nvim-treesitter-textobjects").setup({
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
            goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
            goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
            goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
            goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
        },
    })
end

return Plugin
