local opts = { noremap = true, silent = true }

local addOption = function(description)
	return { silent = true, desc = description }
end

local keymap = vim.keymap.set

--Map space-bar as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------------------Normal mode maps -----------------------------------
----- Toggle spell checking
keymap("n", "<F11>", "<cmd>set spell!<cr>", { desc = "toggle spell" })
keymap("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "toggle spell" })

-- Insert a blank line below or above current line (do not move the cursor),
-- see https://stackoverflow.com/a/16136133/6064933
keymap("n", "<leader>o", "printf('m`%so<ESC>``', v:count1)", { expr = true, desc = "insert line below" })

keymap("n", "<leader>O", "printf('m`%sO<ESC>``', v:count1)", { expr = true, desc = "insert line above" })

-- Paste non-linewise text above or below current line, see https://stackoverflow.com/a/1346777/6064933
keymap("n", "<leader>p", "m`o<ESC>p``", { desc = "paste below current line" })
keymap("n", "<leader>P", "m`O<ESC>p``", { desc = "paste above current line" })

--Create split
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "[S]plit [V]ertical " })
keymap("n", "<leader>sH", ":split<CR>", { desc = "[S]plit [H]orizontal" })

--Windows navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
keymap("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
keymap("n", "<C-u>", "<C-w>k", { desc = "switch window up" })
keymap("n", "<C-d>", "<C-w>j", { desc = "switch window down" })
keymap("n", "<C-w>", "<C-w>r", { desc = "Rotate windows position" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<leader>es", "<C-w>=", { desc = "[E]qual [S]plit" })

-- Navigate buffers
keymap("n", "<leader>bn", ":bnext<CR>", { desc = "[B]uffer [N]ext" })
keymap("n", "<leader>bp", ":bprevious<CR>", { desc = "[B]uffer [P]revious" })
-- Delete a buffer, without closing the window, see https://stackoverflow.com/q/4465095/6064933
keymap("n", "<leader>bd", "<cmd>bprevious <bar> bdelete #<cr>", addOption("delete current buffer"))

-- Saves the file if modified and quit
keymap("n", "<leader>q", "<cmd>confirm q<CR>", addOption("quit current window"))
-- Quit all opened buffers
keymap("n", "<leader>Q", "<cmd>qa!<cr>", addOption("quit nvim"))

-- Fast saving with <leader> and w
keymap("n", "<leader>w", "<cmd>w<cr>", addOption("Save current buffer"))

--central cursor on find or vertical navigation
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
keymap("n", "<C-k>", "<C-u>zz", opts)
keymap("n", "<C-j>", "<C-d>zz", opts)

-------------------Visual Mode maps -------------------------------------------------------
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- keep the selected text after visually pasted
keymap("v", "p", '"_dP', opts)

--------------------- Visual Block Mode maps --------------------------------------------------
-- Move text up and down
keymap("x", "<C-v>", "x", opts)
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)
