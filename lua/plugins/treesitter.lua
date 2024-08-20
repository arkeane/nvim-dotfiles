local Plugin = { "nvim-treesitter/nvim-treesitter" }

Plugin.event = "VeryLazy"
Plugin.build = ":TSUpdate"

Plugin.config = function()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = { "c", "lua", "rust", "python" },
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	})
end

return Plugin
