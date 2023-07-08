-- lsp config

local bo = vim.bo
local keymap = vim.keymap
local lsp = vim.lsp

local M = {}

M.servers = {
	"ocamllsp",
	"pyright",
	"clangd",
	"texlab",
	"lua_ls",
}

local options = {}

local on_attach = function(_, bufnr)
	-- enable completion triggered by <c-x><c-o>
	bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		keymap.set(mode, l, r, opts)
	end

	map("n", "gD", lsp.buf.declaration, { desc = "Goto declaration" })
	map("n", "gd", lsp.buf.definition, { desc = "Goto definition" })
	map("n", "K", lsp.buf.hover, { desc = "See info" })
	map("n", "gi", lsp.buf.implementation, { desc = "Goto implementation" })
	map("n", "<C-k>", lsp.buf.signature_help, { desc = "Signature help" })
	map(
		"n",
		"<space>wa",
		lsp.buf.add_workspace_folder,
		{ desc = "Add workspace folder" }
	)
	map(
		"n",
		"<space>wr",
		lsp.buf.remove_workspace_folder,
		{ desc = "Remove workspace folder" }
	)
	map("n", "<space>wl", function()
		print(vim.inspect(lsp.buf.list_workspace_folders()))
	end, { desc = "List workspace folders" })
	map(
		"n",
		"<space>D",
		lsp.buf.type_definition,
		{ desc = "Goto type definition" }
	)
	map("n", "<space>rn", lsp.buf.rename, { desc = "Rename symbol" })
	map("n", "<space>ca", lsp.buf.code_action, { desc = "Code actions" })
	map("n", "gr", lsp.buf.references, { desc = "List references" })
	map("n", "<space>f", function()
		lsp.buf.format({ async = true })
	end, { desc = "Format file" })
end

local _if = function(value, default)
	if value ~= nil then
		return value
	else
		return default
	end
end

M.setup = function()
	-- just make working with neovim builtins not a pain
	require("neodev").setup()

	local nvim_lspconfig = require("lspconfig")

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	for _, server in ipairs(_if(M.servers, {})) do
		nvim_lspconfig[server].setup({
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
end

return M
