vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.modelines = 0
vim.opt.showcmd = true
vim.opt.encoding = 'utf-8'
vim.opt.syntax = 'on'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.colorcolumn = "120"

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim"
vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 8

vim.g.mapleader = " "
