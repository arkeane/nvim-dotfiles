local Plugin = { "Mofiqul/dracula.nvim" }

Plugin.event = "VimEnter"

Plugin.config = function()
    vim.cmd("colorscheme dracula")  -- Apply the theme
end

return Plugin
