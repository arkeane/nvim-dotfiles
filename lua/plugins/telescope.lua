local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.dependencies = {
	{ "nvim-lua/plenary.nvim" },
}

Plugin.cmd = "Telescope"

Plugin.config = function()
    local telescope = require("telescope")
    telescope.setup({
        pickers = {
            find_files = {
                hidden = true
            }
        }
    })
end

return Plugin

