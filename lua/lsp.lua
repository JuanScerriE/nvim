local lsp = vim.lsp

-- lsp --

local nvim_lsp = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities(lsp.protocol.make_client_capabilities())

local on_attach = require("bindings/lsp-bindings")

local options = require("options/lsp-options")

local function _if(value, default)
	if value ~= nil then
		return value
	else
		return default
	end
end

for _, server in ipairs(_if(options.servers, {})) do
	nvim_lsp[server].setup({
		capabilities = capabilities,
		on_attach = on_attach,

		flags = {
			debounce_text_changes = _if(options.debounce_text_changes, 150),
		},

		handlers = {
			["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
				virtual_text = _if(options.virtual_text, true),
			}),
		},
	})
end
