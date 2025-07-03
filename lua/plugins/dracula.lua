local Plugin = { "Mofiqul/dracula.nvim" }

Plugin.event = "VimEnter"

Plugin.config = function()
    local dracula = require("dracula")
    dracula.setup({
        transparent_bg = true,
    })

    vim.cmd("colorscheme dracula")  -- Apply the theme
end

return Plugin
