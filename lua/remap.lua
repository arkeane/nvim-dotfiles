-- Telescope.nvim remaps
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})

-- Undotree remaps
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Shortcuts
vim.keymap.set("x", "<leader>p", [["_dP]])
