local keymap = vim.keymap

local dap = require("dap")

keymap.set(
    "n",
    "<leader>db",
    dap.toggle_breakpoint,
    { desc = "Toggle breakpoint" }
)
keymap.set(
    "n",
    "<leader>dc",
    dap.continue,
    { desc = "Launch debug session/Resume execution" }
)
