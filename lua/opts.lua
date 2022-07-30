local fn = vim.fn
local opt = vim.opt

-- general options --

-- color scheme
if fn.has("termguicolors") then
	opt.termguicolors = true
end

require("onedark").load()

-- turn off sign column
-- vim.opt.signcolumn = "no"

-- do not use internal clipboard
opt.clipboard = "unnamedplus"

-- line numbers
opt.relativenumber = true
opt.number = true

-- spelling
opt.spelllang = "en_gb"

-- tab configuration
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- mouse functionality
opt.mouse:append("n")

-- turn off bottom layer
opt.showmode = false

-- reduce maximum textwidth
opt.textwidth = 64

-- turn on cursorline
opt.cursorline = true

-- global statusbar
opt.laststatus = 3
