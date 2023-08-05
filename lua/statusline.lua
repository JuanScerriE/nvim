local diagnostic = vim.diagnostic
local tbl_count = vim.tbl_count
local api = vim.api
local lsp = vim.lsp
local wo = vim.wo
local go = vim.go
local b = vim.b

local M = {}

local function lsp_exists()
    return next(lsp.get_active_clients()) ~= nil
end

M.lsp = function()
    if lsp_exists() then
        local error_count = tbl_count(
            diagnostic.get(0, { severity = diagnostic.severity.ERROR })
        )
        local warn_count = tbl_count(
            diagnostic.get(0, { severity = diagnostic.severity.WARN })
        )
        local info_count = tbl_count(
            diagnostic.get(0, { severity = diagnostic.severity.INFO })
        )
        local hint_count = tbl_count(
            diagnostic.get(0, { severity = diagnostic.severity.HINT })
        )

        return string.format(
            "  [E%s W%s I%s H%s] ",
            error_count,
            warn_count,
            info_count,
            hint_count
        )
    else
        return ""
    end
end

local function git_exists()
    return b.gitsigns_status_dict or b.gitsigns_head
end

M.git = function()
    if git_exists() then
        return string.format(
            "  [+%s ~%s -%s | %s] ",
            b.gitsigns_status_dict.added or 0,
            b.gitsigns_status_dict.changed or 0,
            b.gitsigns_status_dict.removed or 0,
            b.gitsigns_status_dict.head
        )
    else
        return ""
    end
end

local function filepath()
    return " %((%M)%) %<%f "
end

local function fileinfo()
    return " %((%M)%)  %y  [%03.5l : %03.5c]  %P "
end

-- NOTE: this would be a nice implementation of active() however
-- according to
-- https://neovim.discourse.group/t/when-bufenter-fires-how-to-determine-if-it-is-a-telescope-prompt/3181
-- Telescope sets the filetype after it BufEnter or WinEnter
-- hence we cannot solve the problem for now.

-- local function active()
--     local buff_type = api.nvim_buf_get_option(0, "filetype")
--
--     if buff_type == "TelescopePrompt" then
--         wo.statusline = "%#Statusline#%= %y %="
--     else
-- 	    wo.statusline = table.concat({
-- 	    	"%#Statusline#",
-- 	    	" %<%t",
-- 	    	"%{luaeval(\"require('statusline').git()\")}",
-- 	    	"%{luaeval(\"require('statusline').lsp()\")}",
-- 	    	"%=",
-- 	    	fileinfo(),
-- 	    })
--     end
-- end

local function active()
    wo.statusline = table.concat({
        "%#Statusline#",
        " %<%t",
        "%{luaeval(\"require('statusline').git()\")}",
        "%{luaeval(\"require('statusline').lsp()\")}",
        "%=",
        fileinfo(),
    })
end

M.setup = function()
    local statusline_gp = api.nvim_create_augroup("Statusline", {
        clear = true,
    })

    go.winbar = table.concat({
        "%=",
        filepath(),
    })

    api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
        callback = active,
        group = statusline_gp,
    })
end

return M
