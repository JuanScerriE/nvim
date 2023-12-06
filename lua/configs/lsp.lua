-- lsp config

local bo = vim.bo
local lsp = vim.lsp
local keymap = vim.keymap

-- vim.lsp.set_log_level("debug")

local telescope_builtin = require("telescope.builtin")

local options = {}

local on_attach = function(_, bufnr)
    -- enable completion triggered by <c-x><c-o>
    bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        keymap.set(mode, l, r, opts)
    end

    map("n", "gd", lsp.buf.definition, { desc = "Goto definition" })
    map(
        "n",
        "gr",
        telescope_builtin.lsp_references,
        { desc = "Goto referneces" }
    )
    map("n", "gI", lsp.buf.implementation, { desc = "Goto implementation" })
    map("n", "<leader>D", lsp.buf.type_definition, { desc = "Type definition" })
    map(
        "n",
        "<leader>ds",
        telescope_builtin.lsp_document_symbols,
        { desc = "Document symbols" }
    )
    map("n", "K", lsp.buf.hover, { desc = "See info" })
    map("n", "<C-k>", lsp.buf.signature_help, { desc = "Signature help" })

    map("n", "gD", lsp.buf.declaration, { desc = "Goto declaration" })
    map(
        "n",
        "<space>Wa",
        lsp.buf.add_workspace_folder,
        { desc = "Add workspace folder" }
    )
    map(
        "n",
        "<space>Wr",
        lsp.buf.remove_workspace_folder,
        { desc = "Remove workspace folder" }
    )
    map("n", "<space>Wl", function()
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

local servers = {
    clangd = {},
    tsserver = {},
    kotlin_language_server = {},
    rust_analyzer = {},
    erlangls = {},
    elixirls = {},
    ocamllsp = {
        single_file_support = true,
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                },
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    },
}

local nvim_lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities(
    lsp.protocol.make_client_capabilities()
)
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        nvim_lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,

            settings = _if(servers[server_name].settings, {}),
            filetypes = _if(servers[server_name].filetypes, nil),
            single_file_support = _if(
                servers[server_name].single_file_support,
                nil
            ),

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
    end,
})
