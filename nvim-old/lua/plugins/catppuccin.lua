return {
	"catppuccin/nvim",
	name = "catppuccin", 
	priority = 1000,
    lazy = false,
    transparent_background = true,
    no_italics = true,
	config = function()
		vim.cmd.colorscheme 'catppuccin'
    end
}
