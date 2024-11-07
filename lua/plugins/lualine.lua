--Status line for vim
local icons = require("helpers.icons")

local mode = {
	"mode",
	fmt = function(str)
		-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
		return " " .. str
	end,
}

local filename = {
	"filename",
	file_status = true, -- displays file status (readonly status, modified status)
	path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
	symbols = { readonly = icons.ui.Lock },
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 100
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = {
		error = icons.diagnostics.BoldError,
		warn = icons.diagnostics.BoldWarning,
		info = icons.diagnostics.BoldInformation,
		hint = icons.diagnostics.BoldHint,
	},
	colored = true,
	update_in_insert = false,
	always_visible = false,
	cond = hide_in_width,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineModified }, -- changes diff symbols
	cond = hide_in_width,
}

local spell = function()
	if vim.o.spell then
		return string.format("[spell]")
	end
	return ""
end

local get_active_lsp = function()
	local msg = "No Active LSP"
	local buffer_fileType = vim.api.nvim_get_option_value("filetype", {})
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if next(clients) == nil then
		return msg
	end

	for _, client in ipairs(clients) do
		---@diagnostic disable-next-line: undefined-field
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buffer_fileType) ~= -1 then
			return client.name
		end
	end
	return msg
end

local Module = {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
}

function Module.config()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "alpha", "neo-tree", "Avante" },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { mode },
			lualine_b = {
				{
					"branch",
					fmt = function(name, _)
						return string.sub(name, 1, 20)
					end,
				},
			},
			lualine_c = {
				filename,
				{ spell, color = { fg = "black", bg = "#a7c080" } },
			},
			lualine_x = {
				diagnostics,
				diff,
				{ get_active_lsp, icon = " LSP:" },
			},
			lualine_y = { "encoding", "fileformat", "filetype" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { "quickfix", "man", "fugitive" },
	})
end
return Module
