local opt = vim.opt
local fn = vim.fn
local g = vim.g

-- install lazy if it is not installed
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

opt.rtp:prepend(lazypath)

-- set the leader and local leader
g.mapleader = " "
g.maplocalleader = " "

local config_lsp = require("configs.lsp")

-- deal with plugins
require("lazy").setup({

    -- manages my external dependencies
    {
        "williamboman/mason.nvim",
        opts = {},
    },

    ------------------LSP------------------

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp",
            {
                "j-hui/fidget.nvim",
                event = "LspAttach",
                tag = "legacy",
                opts = { text = { spinner = "line" } },
            },
            "folke/neodev.nvim",
        },
        config = function()
            config_lsp.setup()
        end,
    },

    -- let mason manage my lspconfig as well
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = config_lsp.servers,
            })
        end,
    },

    ------------------AUTO COMPLETE------------------

    -- nvim cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
        },
        config = function()
            require("configs.completion")
        end,
    },

    -- nvim cmp luasnip compatibility
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
        },
    },

    ------------------AUX------------------

    -- tell me which key comes next
    {
        "folke/which-key.nvim",
        opts = {},
    },

    -- make autopairs a thing
    {
        "windwp/nvim-autopairs",
        opts = {},
    },

    -- comment related improvements
    {
        "numToStr/Comment.nvim",
        opts = {},
    },

    -- detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- write nicely typeset math in neovim (tex/latex integration)
    {
        "lervag/vimtex",
        ft = "tex",
        init = function()
            g.vimtex_compiler_latexmk_engines = {
                ["_"] = "-lualatex",
            }
        end,
    },

    -- git integration (magit is actually good)
    {
        "lewis6991/gitsigns.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("configs.gitsigns")
        end,
    },

    -- i wish we had a fuzzy finder for physical paper
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return fn.executable("make") == 1
                end,
            },
        },
        config = function()
            require("configs.telescope")
        end,
    },

    -- somehow sitting on trees makes code look nicer
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("configs.treesitter")
        end,
    },

    -- i need a cappuccino made by cat
    { "catppuccin/nvim", name = "catppuccin" },
}, {
    ui = {
        icons = {
            cmd = "cmd",
            config = "config",
            event = "event",
            ft = "ft",
            init = "init",
            keys = "keys",
            plugin = "plugin",
            runtime = "runtime",
            source = "source",
            start = "start",
            task = "task",
            lazy = "lazy",
        },
    },
})

-- common options related to neovim
require("common.bindings")
require("common.options")

-- setup the statusline
require("statusline").setup()
