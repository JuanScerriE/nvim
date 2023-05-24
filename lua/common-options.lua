local fn = vim.fn
local opt = vim.opt

-- general options --

-- color scheme
if fn.has("termguicolors") then
	opt.termguicolors = true
end

vim.cmd.colorscheme("gruber-darker")

-- do not use internal clipboard
opt.clipboard = "unnamedplus"

-- line numbers
opt.relativenumber = true
opt.number = true

-- spelling
opt.spelllang = "en_gb"

-- tab configuration
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- mouse functionality
opt.mouse:append("n")

-- turn on bottom layer
opt.showmode = true

-- reduce maximum textwidth
opt.textwidth = 64

-- turn on cursorline
opt.cursorline = true

-- global statusbar
opt.laststatus = 3

-- always vertical split to the right
opt.splitright = true
