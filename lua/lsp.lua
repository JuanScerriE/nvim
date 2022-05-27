-- lsp --

local nvim_lsp = require("lspconfig")

local on_attach = require("lsp-binds")

local servers = { "clangd", "zls", "rls", "jdtls", "jedi_language_server" }

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		handlers = {
			["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				-- disable virtual_text
				virtual_text = false,
			}),
		},
	})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = nil
