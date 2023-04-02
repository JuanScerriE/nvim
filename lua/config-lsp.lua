local lsp = vim.lsp

-- lsp --

require("neodev").setup()

local nvim_lsp = require("lspconfig")

local options = {
	servers = {
		"rust_analyzer",
		"pyright",
		"clangd",
		"texlab",
		"lua_ls",
	},
	debounce_text_changes = 150,
	virtual_text = true,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(lsp.protocol.make_client_capabilities())

local on_attach = function(_, bufnr)
	-- enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	local opts = { buffer = bufnr }

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

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
