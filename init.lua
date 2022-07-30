-- init --

-- install packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

-- plugins
require("plugs")

-- options
require("plug-opts")
require("opts")

-- lsp & auto-complete
require("aucmp")
require("lsp")

-- bindings
require("binds")
require("plug-binds")
require("lsp-binds")

-- autocmds
require("statusline2")
require("autocmds")
