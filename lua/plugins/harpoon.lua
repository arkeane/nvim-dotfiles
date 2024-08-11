local Plugin = { "ThePrimeagen/harpoon" }

Plugin.branch = "harpoon2"

Plugin.dependencies = {
	"nvim-lua/plenary.nvim",
}

-- Lazy load the plugin when any of the key mappings or commands are used
Plugin.keys = { "<leader>a", "<C-e>", "<C-h>", "<C-t>", "<C-n>", "<C-s>", "<C-S-P>", "<C-S-N>" }

Plugin.config = function()
	local harpoon = require("harpoon")
	harpoon:setup({})

	vim.keymap.set("n", "<leader>a", function()
		harpoon:list():add()
	end)
	vim.keymap.set("n", "<C-e>", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end)

	vim.keymap.set("n", "<C-h>", function()
		harpoon:list():select(1)
	end)
	vim.keymap.set("n", "<C-t>", function()
		harpoon:list():select(2)
	end)
	vim.keymap.set("n", "<C-n>", function()
		harpoon:list():select(3)
	end)
	vim.keymap.set("n", "<C-s>", function()
		harpoon:list():select(4)
	end)

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-S-P>", function()
		harpoon:list():prev()
	end)
	vim.keymap.set("n", "<C-S-N>", function()
		harpoon:list():next()
	end)
end
return Plugin
