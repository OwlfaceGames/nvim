-----------------
-- vim options --
-----------------
vim.cmd("let g:netrw_liststyle = 3") -- set exploreer style to tree

-- swap p and shift p binds for visual mode for normal paste over functionality
vim.keymap.set('v', 'p', 'P', { noremap = true })
vim.keymap.set('v', 'P', 'p', { noremap = true })

local opt = vim.opt                  -- set local var for vim opt

opt.relativenumber = true            -- set line numbers
opt.number = true

opt.wrap = false

-- Disable Shift+J
vim.keymap.set('n', 'J', '<Nop>', { noremap = true })

-- tabs & indentation
opt.tabstop = 4       -- 4 stpaces for tabs
opt.shiftwidth = 4    -- 4 spaces for indent width
opt.expandtab = true  -- expand tab spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- if you include mixed case in your search. assumes you want case-sensitive

-- turn on termguicolors for certain colorschemes to work
opt.termguicolors = true
opt.background = "dark" -- sets colorschemes to dark mode
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard

-- split windows
opt.splitright = true -- split vertical window to right
opt.splitbelow = true -- split horizontal window to the bottom

-- snake case counts as word
opt.iskeyword:append("-")
opt.iskeyword:append("_")

-- thick cursor
opt["guicursor"] = ""

-- add column to warn when code is getting too long
vim.opt.colorcolumn = "80"
