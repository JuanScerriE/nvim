local diagnostic = vim.diagnostic
local keymap = vim.keymap

-- default bindings --

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- diagnostics
keymap.set(
    "n",
    "<space>e",
    diagnostic.open_float,
    { desc = "See diagnostic message" }
)
keymap.set(
    "n",
    "[d",
    diagnostic.goto_prev,
    { desc = "Goto previous diagnostic" }
)
keymap.set("n", "]d", diagnostic.goto_next, { desc = "Goto next diagnostic" })
keymap.set(
    "n",
    "<space>q",
    diagnostic.setloclist,
    { desc = "View diagnostics" }
)

-- toggle spell check
keymap.set(
    "n",
    "<leader>s",
    "<cmd>set spell!<cr>",
    { noremap = true, silent = true, desc = "Toggle spell check" }
)

-- move between buffers
keymap.set(
    "n",
    "<leader>bp",
    "<cmd>bprev<cr>",
    { noremap = true, silent = true, desc = "Previous buffer" }
)
keymap.set(
    "n",
    "<leader>bn",
    "<cmd>bnext<cr>",
    { noremap = true, silent = true, desc = "Next buffer" }
)

-- Remap for dealing with word wrap
keymap.set(
    { "n", "v" },
    "k",
    "v:count == 0 ? 'gk' : 'k'",
    { expr = true, silent = true }
)
keymap.set(
    { "n", "v" },
    "j",
    "v:count == 0 ? 'gj' : 'j'",
    { expr = true, silent = true }
)

-- remap the window management
keymap.set("n", "<leader>w", "<C-w>", { noremap = true, silent = true })
