local Module = {
	"nvim-telescope/telescope-frecency.nvim",
}

function Module.config()
	require("telescope").load_extension("frecency")
	vim.keymap.set("n", "<leader>sF", "<cmd>Telescope frecency <CR>", { desc = "[S]earch frequently used file" })
end
return Module
