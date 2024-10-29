-- DESCRIPTION: General neovim settings and configuration

local opt = vim.opt
local g = vim.g

local indent = 4

g.mapleader =" "

opt.backspace = { "eol", "start", "indent" } -- allow backspacing over everything in insert mode
opt.clipboard = "unnamedplus"                -- allow neovim to access the system clipboard
opt.fileencoding = "utf-8"               -- the encoding written to a file
opt.encoding = "utf-8"                       -- the encoding
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"

-- indention
opt.autoindent = true    -- auto indentation
opt.expandtab = true     -- convert tabs to spaces
opt.shiftwidth = indent  -- the number of spaces inserted for each indentation
opt.smartindent = true   -- make indenting smarter
opt.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
opt.tabstop = indent     -- insert 2 spaces for a tab
opt.shiftround = true    -- use multiple of shiftwidth when indenting with "<" and ">"


-- search
opt.hlsearch = true   -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true  -- smart case
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true   -- make tab completion for files/buffers act like bash
opt.inccommand = "split"

-- ui
opt.cursorline = true -- highlight the current line
opt.laststatus = 2    -- only the last window will always have a status line
opt.lazyredraw = true -- don"t update the display while executing macros
opt.list = true
opt.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×"
}

-- Hide cmd line
opt.cmdheight = 2      -- more space in the neovim command line for displaying messages

--number lines
opt.number = true      -- set numbered lines
opt.relativenumber = true
opt.numberwidth = 2       --set number columns width (default 4)

--Line breaks 
opt.wrap = false       -- display a long line
opt.linebreak = true


opt.mouse = "a"        -- allow the mouse to be used in neovim
opt.scrolloff = 8     -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 3  -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

--Split windows
opt.splitbelow = true  -- open new split below
opt.splitright = true  -- open new split to the right


-- backups
opt.backup = false      -- create a backup file
opt.swapfile = false    -- creates a swapfile
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited


-- autocomplete
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
opt.shortmess = opt.shortmess + {
    c = true
} -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

opt.showmode = false --Hide mode status 

-- perfomance
-- remember N lines in history
opt.history = 100    -- keep 100 lines of history
opt.redrawtime = 1500
opt.timeoutlen = 600 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.ttimeoutlen = 10
opt.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- theme
opt.termguicolors = true -- enable 24-bit RGB colors

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
local undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true -- enable persistent undo
opt.undodir =  undodir
opt.undolevels = 1000
opt.undoreload = 10000

-- fold
opt.foldmethod = "marker"
opt.foldlevel = 99

opt.conceallevel = 0  -- so that `` is visible in markdown files

opt.showtabline = indent --always show tabs


opt.iskeyword:append "-"                           -- hyphenated words recognized by searches

--Netrw
g.netrw_banner = 0

-- Folding using treesitter: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
