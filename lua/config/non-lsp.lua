local M = {}

local servers = {
	"black",
}

local are_installed = function()
	local mason_registery = require("mason-registry")

	for _, server in ipairs(servers) do
		if not mason_registery.is_installed(server) then
			error(
				string.format(
					"'%s' is not installed, try :MasonInstall %s",
					server,
					server
				)
			)
		end
	end
end

M.setup = function()
	are_installed()

	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.black,
		},
	})
end

return M
