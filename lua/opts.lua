-- general options --

-- color scheme
if vim.fn.has("termguicolors") then
	vim.opt.termguicolors = true
end

vim.cmd("colorscheme nord")

-- do not use internal clipboard
vim.opt.clipboard = "unnamedplus"

-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- spelling
vim.opt.spelllang = "en_gb"

-- tab configuration
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- mouse functionality
vim.opt.mouse:append("n")

-- turn off bottom layer
vim.opt.showmode = false
