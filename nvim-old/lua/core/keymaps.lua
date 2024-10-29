--Leader key
vim.g.mapleader = " "
vim.g.maplocalleadeer = " "
vim.keymap.set({'n','v'}, '<Space>', '<Nop>', {silent = true}) --Disable spacebar default behaviour

-- Common opts for keymaps used below
local opts = {noremap = true, silent = true}


-- Clear highlights on search when pressing <Esc> in normal mode. See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')



--Exit terminal mode in the builtin terminal with a shortcut that is a bit easier; built-in <C-\><C-n>
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--Split windows
vim.keymap.set('n','<leader>sv',':vsplit<CR>', {desc = '[s]plit [v]ertically'})
vim.keymap.set('n','<leader>sh',':split<CR>', {desc = '[s]plit [h]orizontally'})
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) --equal splits windows size
vim.keymap.set('n', '<leader>sc', ':close<CR>', opts) --close split window

--Windows navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--Resize windows with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)


--Bufffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts) --next buffer
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts) --previous buffer
vim.keymap.set('n', '<leader>bd', ':bd<CR>',opts) --close buffer
vim.keymap.set('n', '<leader>bN', '<cmd> enew CR>', opts) --new buffer


-- Highlights when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})



--Save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

--Save without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts)

--delete single char without copying to register
vim.keymap.set('n', 'x', '"_x', opts)

--Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

--Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

--Stay in visual mode after indenting
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '<gv', opts)

--keep last yanked object when pasting
vim.keymap.set('v', 'p', '"_dP', opts)
