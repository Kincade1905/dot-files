-- File Manager for Nvim
local Module = {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function Module.config()
	local keymaps = require("keymaps").oil

	require("oil").setup({
		default_file_explorer = true,
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
			natural_order = true,
			is_always_hidden = function(name, _)
				return name == ".git"
			end,
		},
		win_options = {
			wrap = true,
		},
		float = {
			padding = 2,
			border = "rounded",
		},
		keymaps.config(),
	})
end
return Module
