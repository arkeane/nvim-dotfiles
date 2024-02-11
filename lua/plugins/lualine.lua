local Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.event = "VeryLazy"

Plugin.dependencies = { "nvim-tree/nvim-web-devicons" }

Plugin.opts = {
	options = {
		icons_enabled = true,
		theme = "dracula-nvim",
		component_separators = "|",
		section_separators = "",
	},
}

function Plugin.init()
	vim.opt.showmode = false
end

return Plugin
