local lsp = vim.lsp

-- lsp --

local capabilities = lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local nvim_lsp = require("lspconfig")

local on_attach = require("lsp-binds")

local servers = { "svelte", "sumneko_lua", "clangd", "zls", "rls", "jedi_language_server" }

for _, server in ipairs(servers) do
	nvim_lsp[server].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
		handlers = {
			["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
				-- disable virtual_text
				virtual_text = false,
			}),
		},
	})
end

-- lsp.handlers["textDocument/publishDiagnostics"] = nil
