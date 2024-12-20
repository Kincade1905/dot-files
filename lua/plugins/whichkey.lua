local Module = {
	"folke/which-key.nvim",
}

function Module.config()
	local mappings = {
		h = { "<cmd>nohlsearch<CR>", "NO HL" },
		[";"] = { "<cmd>tabnew | terminal<CR>", "Term" },
		b = { name = "Buffers" },
		d = { name = "Debug" },
		s = { name = "Search" },
		g = { name = "Git" },
		l = { name = "LSP" },
		p = { name = "Plugins" },
		t = { name = "Test" },
		x = { name = "Trouble" },
		a = {
			name = "Tab",
			n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
			N = { "<cmd>tabnew %<cr>", "New Tab" },
			o = { "<cmd>tabonly<cr>", "Only" },
			h = { "<cmd>-tabmove<cr>", "Move Left" },
			l = { "<cmd>+tabmove<cr>", "Move Right" },
		},
		-- T = { name = "Treesitter" },
	}

	local which_key = require("which-key")
	which_key.setup({
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		window = {
			border = "rounded",
			position = "bottom",
			padding = { 2, 2, 2, 2 },
		},
		ignore_missing = true,
		show_help = false,
		show_keys = false,
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
	})

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
	}

	which_key.register(mappings, opts)
end

return Module
