-- general options --

-- color scheme
if vim.fn.has("termguicolors") then
	vim.opt.termguicolors = true
end

require("onedark").load()

-- turn off sign column
-- vim.opt.signcolumn = "no"

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

-- reduce maximum textwidth
vim.opt.textwidth = 64

-- turn on cursorline
vim.opt.cursorline = true

-- global statusbar
vim.opt.laststatus = 3
