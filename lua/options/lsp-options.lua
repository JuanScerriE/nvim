-- lsp options --

local M = {}

M.servers = {
	"rust_analyzer",
	"pyright",
	"clangd",
	"texlab",
	"lua_ls",
}

M.debounce_text_changes = 150
M.virtual_text = true

return M
