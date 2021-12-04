-- init --

-- install packer if not installed
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

require("plugs")

require("opts")
require("plug-opts")

require("lsp")
require("aucmp")

require("binds")
require("plug-binds")
require("lsp-binds")
