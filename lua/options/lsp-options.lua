-- lsp options --

local M = {}

M.servers = {
	"svelte",
	"sumneko_lua",
	"clangd",
	"zls",
	"rls",
	"jedi_language_server",
}

M.debounce_text_changes = 150
M.virtual_text = true

return M
