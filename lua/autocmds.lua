local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.lua" },
	desc = "Automatically format lua files after saving",
	callback = function()
		local fileName = vim.api.nvim_buf_get_name(0)
		vim.cmd(":!stylua " .. fileName)
	end,
	group = autocmd_group,
})
