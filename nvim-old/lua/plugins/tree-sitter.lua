return {
	'nvim-treesitter/nvim-treesitter',
    dependencies = {   "windwp/nvim-ts-autotag" }, -- automatically close tags
	build = ':TSUpdate',
	config = function()
		local config = require('nvim-treesitter.configs')
		config.setup({
            auto_install = true,
			ensure_installed = {'lua', 'diff', 'html', 'luadoc', 'markdown', 'markdown_inline','query','vim',
                 'vimdoc', 'javascript', 'typescript', 'c_sharp', 'css', 'json', 'gitignore'},

			highlight = {enable = true},
			indent = {enable = true },
            autotag = {enable = true},
		})
	end
}

