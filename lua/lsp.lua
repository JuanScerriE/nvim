-- lsp --

local nvim_lsp = require("lspconfig")

local on_attach = require("lsp-binds")

local servers = { "texlab", "clangd" }

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end
