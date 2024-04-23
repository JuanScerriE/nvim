local fn = vim.fn
local opt = vim.opt

-- general options --

-- set termguicolors
if fn.has("termguicolors") then
    opt.termguicolors = true
end

-- set background
opt.background = "dark"

-- set theme
vim.cmd.colorscheme("gruber-darker")

-- enable break indent
opt.breakindent = true

-- don't reach the border
opt.scrolloff = 5

-- save undo history
opt.undofile = true

-- case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- keep signcolumn on by default
opt.signcolumn = "yes"

-- decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- do not use internal clipboard
opt.clipboard = "unnamedplus"

-- relative line numbers
opt.relativenumber = true
opt.number = true

-- spelling
opt.spelllang = "en_gb"

-- mouse functionality
opt.mouse:append("n")

-- turn on bottom layer
opt.showmode = true

-- reduce maximum textwidth
opt.textwidth = 64

-- set textwidth format options
opt.formatoptions = "cqjl"

-- turn on cursorline
opt.cursorline = true

-- global statusbar
opt.laststatus = 3

-- disable highligh when searching
opt.hlsearch = false

-- always vertical split to the right
opt.splitright = true

-- automatically change directory
opt.autochdir = false

-- ruler
opt.colorcolumn = "60"
