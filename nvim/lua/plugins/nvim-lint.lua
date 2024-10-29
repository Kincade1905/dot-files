local Module = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
}

function Module.config()
	local lint = require("lint")
	local conform = require("conform")
	lint.linters_by_ft = {
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		vue = { "eslint_d" },
	}

	local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_group,
		callback = function()
			lint.try_lint()
		end,
	})
	vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		lint.try_lint()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		})
	end, { desc = "[M]ake pretty by linting and formatting" })
end

return Module
