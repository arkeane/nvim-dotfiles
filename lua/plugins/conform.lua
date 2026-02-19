local Plugin = { "stevearc/conform.nvim" }

Plugin.event = { "BufWritePre" }
Plugin.cmd = { "ConformInfo" }

Plugin.opts = {
    formatters_by_ft = {
        lua = { "stylua" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}

return Plugin
