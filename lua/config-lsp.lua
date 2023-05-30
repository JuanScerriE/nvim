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
        "tsserver",
        "svelte",
		"zls",
	},
	debounce_text_changes = 150,
	virtual_text = true,
}

local capabilities = require("cmp_nvim_lsp").default_capabilities(
	lsp.protocol.make_client_capabilities()
)

local on_attach = function(_, bufnr)
	-- enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
	map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
	map("n", "K", vim.lsp.buf.hover, { desc = "See info" })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
	map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
	map(
		"n",
		"<space>wa",
		vim.lsp.buf.add_workspace_folder,
		{ desc = "Add workspace folder" }
	)
	map(
		"n",
		"<space>wr",
		vim.lsp.buf.remove_workspace_folder,
		{ desc = "Remove workspace folder" }
	)
	map("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { desc = "List workspace folders" })
	map(
		"n",
		"<space>D",
		vim.lsp.buf.type_definition,
		{ desc = "Goto type definition" }
	)
	map("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
	map("n", "<space>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
	map("n", "gr", vim.lsp.buf.references, { desc = "List references" })
	map("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format file" })
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
			["textDocument/publishDiagnostics"] = lsp.with(
				lsp.diagnostic.on_publish_diagnostics,
				{
					virtual_text = _if(options.virtual_text, true),
				}
			),
		},
	})
end
