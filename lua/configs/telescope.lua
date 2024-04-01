local cmd = vim.cmd
local keymap = vim.keymap

local telescope = require("telescope")

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
                ["<C-c>"] = function()
                    cmd([[stopinsert]])
                end,
                ["<C-u>"] = false,
                ["<C-d>"] = false,
            },
        },
        -- border = false,
        borderchars = {
            prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
            results = { " ", " ", " ", " ", " ", " ", " ", " " },
            preview = { " ", " ", " ", " ", " ", " ", " ", " " },
        },
        layout_config = {
            height = 10,
        },
        layout_strategy = "bottom_pane",
        sorting_strategy = "ascending",
        theme = "ivy",
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case",
        },
    },
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

keymap.set("n", "<leader>.", builtin.find_files, { desc = "Search files" })
keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep in files" })
keymap.set("n", "<leader>b", builtin.buffers, { desc = "Search buffers" })
keymap.set("n", "<leader>?", builtin.help_tags, { desc = "Search help" })

keymap.set("n", "<leader>ld", builtin.lsp_document_symbols, { desc = "List documet symbols"})
keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "List workspace symbols"})
