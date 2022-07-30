M = {}

require("statusline.theme").setup("gruvbox")

status = require("statusline.status")
<<<<<<< HEAD

-- [[
-- {
--  component = {
--    mode = {
--      disable = false,
--      length = 80,
--    },
--
--    filename = {
--      disable = false,
--      length = 80,
--    },
--
--    lsp_diagnostics ={
--      disable = true,
--    },
--
--    git_status = {
--      disable = false,
--    },
--  },
--
--  section = {
--
--  }
--
-- }
-- ]]

local configuration = require("statusline.defaults")

local switch_case = {
  mode = function(opts)
  end,
  filename = function(opts)
  end,
  filetype = function(opts)
  end,
  lsp_status = function(opts)
  end,
  git_status = function(opts)
  end,
  line_column = function(opts)
  end,
}

statusline.setup = function(_, opts)
  if opts then -- true
    local components = opts.components
    local sections = opts.sections
    
    if components then
      for component, component_opts in pairs(components) do
        switch_case[component](component_opts)
      end
    end

    if section then
    end
  end

	local statusline_gp = vim.api.nvim_create_augroup("Statusline", {
		clear = true,
	})

	vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
		callback = status.active,
		group = statusline_gp,
	})

	vim.api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
		callback = status.inactive,
		group = statusline_gp,
	})
=======
build = require("statusline.build")

M.setup = function(_, opts)
	vim.wo.statusline = build.statusline(opts)

	-- local statusline_gp = vim.api.nvim_create_augroup("Statusline", {
	-- 	clear = true,
	-- })
	--
	-- vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
	-- 	callback = status.active,
	-- 	group = statusline_gp,
	-- })
	--
	-- vim.api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
	-- 	callback = status.inactive,
	-- 	group = statusline_gp,
	-- })
>>>>>>> 031e81a8af00dadc80f5b224a40e0aa6ed94be90
end

return M
