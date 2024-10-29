--Nerd font
vim.g.have_nerd_font = true

--Enable term colur
vim.opt.termguicolors = true

--Line numbers
vim.opt.number = true --Enable line number 
vim.opt.relativenumber = true --Enable relative line number (default: false)
vim.opt.cursorline = true	--highlight current cursor line
vim.opt.scrolloff = 8 		--Minimal number of screen lines to keep above, below cursor

--Sync clipboard between neovim and OS
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
  end)


--File 
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.fileencoding ='utf-8'

--Keep the sign column; used by LSP
vim.opt.signcolumn = 'yes'

--Decrease update time in ms
vim.opt.updatetime = 50

--Decrease mapped sequences wait time
vim.opt.timeoutlen = 600


--Windows split
vim.opt.splitright = true
vim.opt.splitbelow = true


-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

--Line wrap and line break
vim.o.wrap = false --Display lines as one long line 
vim.o.linebreak = true --Companion to wrap, don't split words

--Enable mouse mode
vim.opt.mouse = 'a'

--Don't show Vim's mode
vim.opt.showmode = false

--Searching/Cases
vim.opt.ignorecase = true   --Case-insensitive searching unless \c in search
vim.opt.smartcase = true    --smart case
vim.opt.hlsearch = true    -- Disable highlist search
vim.opt.incsearch = true

--Indention and spacing behaviours
vim.opt.expandtab = true
vim.opt.shiftwidth = 4      --Then number of spaces for each indention
vim.opt.tabstop = 4         --Then number of spaces for the character
vim.opt.softtabstop = 4     --Number of spaces for <Tab> key
vim.opt.smartindent = true
vim.opt.autoindent = true   --Copy intent from previous line to current line 
vim.opt.breakindent = true  --Enable break point
