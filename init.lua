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

-- deal with plugins
require("lazy").setup({
    ------------------TELESCOPE------------------

    -- plenary is a helper library
    "nvim-lua/plenary.nvim",

    -- i wish we had a fuzzy finder for physical paper
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                cond = function()
                    return fn.executable("make") == 1
                end,
                build = "make",
            },
        },
        config = function()
            require("configs.telescope")
        end,
    },

    ------------------TREESITTER------------------

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

    ------------------GIT------------------

    -- anything from tpope is good (magit is actually good)
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- git gutter
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("configs.gitsigns")
        end,
    },

    ------------------LSP------------------

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",

            { "folke/neodev.nvim",       ft = "lua",   opts = {} },

            {
                "j-hui/fidget.nvim",
                tag = "legacy",
                opts = { text = { spinner = "line" } },
            },
        },
        config = function()
            require("configs.lsp")

            require("autoformat")()
        end,
    },

    ------------------AUTOCOMPLETE------------------

    -- nvim cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",

            -- nvim  cmp luasnip compatibility
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            require("configs.completion")
        end,
    },

    ------------------THEMES------------------

    -- i need a cappuccino made by cat
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    ------------------LATEX------------------

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

    ------------------AUXILIARY------------------

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

    -- make netrw great again
    "tpope/vim-vinegar",

    -- fennel boiii
    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').add_default_mappings()
        end,
    }
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
