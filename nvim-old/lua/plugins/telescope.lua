return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function ()
		local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<C-p>',      builtin.git_files, {desc = 'find git files'})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = '[F]ind [H]elp tags'})
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = '[F]ind [F]iles'})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = '[F]ind by [G]rep'})
        vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
        vim.keymap.set('n', '<leader>fr', builtin.resume, {desc = '[F]ind [R]esume'}) --Resume previous search
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = '[F]ind Existing [B]uffers'})
	end
}


