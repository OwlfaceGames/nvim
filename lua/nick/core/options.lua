local opt = vim.opt -- set local var for vim opt

opt.relativenumber = false -- set line numbers
opt.number = false

opt.wrap = false

-- Disable Shift+J
vim.keymap.set('n', 'J', '<Nop>', { noremap = true })

-- tabs & indentation
opt.tabstop = 4       -- 8 spaces for tabs
opt.shiftwidth = 4    -- 8 spaces for indent width
opt.expandtab = true  -- expand tab spaces
opt.smartindent = true

-- stop annoying backups
opt.swapfile = false
opt.backup = false

-- improve scrolling
opt.scrolloff = 8

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
-- opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250" -- flashing default cursors
-- opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:block,o:block,a:blinkwait700-blinkoff400-blinkon250" -- flahsing block

-- turn on color column
opt.colorcolumn = "80"

-- cursorline
-- opt.cursorline = true

-- make terminal title show file name
opt.title = true

-- turn on inline diagnostics
vim.diagnostic.config({ virtual_text = true })

-- turn on winbar
-- opt.winbar="%f"

-- create undo files
opt.undofile = true

-- highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
