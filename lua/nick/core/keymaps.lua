vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- swap p and shift p binds for visual mode for normal paste over functionality
keymap.set('v', 'p', 'P', { noremap = true })
keymap.set('v', 'P', 'p', { noremap = true })

-- Map gd to LSP definition
keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, desc = "goto definition" })
keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true, desc = "open references in quick list" })

-- clear highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- close current buffer
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- split buffers
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })

-- telescope keybinds
keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<CR>", { desc = 'Telescope find files' })
keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<CR>", { desc = 'Telescope live grep' })
keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<CR>", { desc = 'Telescope buffers' })
keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<CR>", { desc = 'Telescope todos' })
keymap.set('n', '<leader>fk', "<cmd>Telescope keymaps<CR>", { desc = 'Telescope keymaps' })

-- telescope fuzzy find references
keymap.set('n', '<leader>fr', function()
    require('telescope.builtin').lsp_references({
        position_encoding = vim.lsp.get_clients({ bufnr = 0 })[1].offset_encoding
    })
end, {desc = "Telescope references"})

-- no neck pain
keymap.set("n", "<leader>nn", "<cmd>NoNeckPain<CR>", { desc = "Toggle no neck pain" })

-- line numbers
keymap.set('n', '<leader>nln', ':setlocal nonumber norelativenumber <CR>', {desc = "turn off line numbers"})
keymap.set('n', '<leader>lrn', ':setlocal number relativenumber <CR>', {desc = "relative line numbers"})
keymap.set('n', '<leader>lnn', ':setlocal number norelativenumber <CR>', {desc = "normal line numbers"})

-- oil
keymap.set('n', '<leader>o', ':Oil<CR>', {desc = "open oil file manager"})

-- open exporer
keymap.set('n', '<leader>e', ':Neotree<CR>', {desc = "open neotree file tree"})

-- neocodeium
keymap.set('n', '<leader>n', ':NeoCodeium toggle<CR>', {desc = "turn on ai auto complete"})

-- quick list
keymap.set('n', '<leader>qo', ':copen<CR>', {desc = "open quick fix list"})
keymap.set('n', '<leader>qn', ':cnext<CR>', {desc = "next item in quick list"})
keymap.set('n', '<leader>qp', ':cprev<CR>', {desc = "previous item in quick list"})
keymap.set('n', '<leader>qt', ':TodoQuickFix<CR>', {desc = "show todos in quick list"})

-- new floating terminal
keymap.set('n', '<leader>t', ':ToggleTerm<CR>', {desc = "open floating terminal"})

-- quit terminal mode
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {desc = "quit terminal mode"})

-- Key mappings for debugging
keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "Start/Continue debugging" })
keymap.set('n', '<F4>', function() require('dap').terminate() end, { desc = "Stop debugging" })
keymap.set('n', '<F1>', function() require('dap').step_over() end, { desc = "Step over in debugger" })
keymap.set('n', '<F2>', function() require('dap').step_into() end, { desc = "Step into in debugger" })
keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = "Step out in debugger" })
keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint for debugger" })
keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = "Open DAP REPL for debugger" })
keymap.set('n', '<Leader>du', function() require('dapui').toggle() end, { desc = "Toggle DAP UI for debugger" })

-- Resize vim window
keymap.set('n', '<leader>k', ':resize -2<CR>', { silent = true , desc = "resize buffer up"})
keymap.set('n', '<leader>j', ':resize +2<CR>', { silent = true , desc = "resize buffer down"})
keymap.set('n', '<leader>h', ':vertical resize -2<CR>', { silent = true , desc = "resize buffer left"})
keymap.set('n', '<leader>l', ':vertical resize +2<CR>', { silent = true , desc = "resize buffer right"})

-- set color column
keymap.set('n', '<leader>lc', ':set colorcolumn=80<CR>', { silent = true, desc = "turn on color column"})
keymap.set('n', '<leader>nlc', ':set colorcolumn=<CR>', { silent = true , desc = "turn color column off"})

-- set winbar
keymap.set('n', '<leader>wb', ':set winbar=%f<CR>', { silent = true, desc = "turn winbar on (filename)"})
keymap.set('n', '<leader>nwb', ':set winbar=<CR>', { silent = true, desc = "turn winbar off (filename)"})

-- open starter
keymap.set("n", "<leader>s", function()
    require("mini.starter").open()
end, { desc = "Open Mini Starter" })

-- prevent s remaps
vim.keymap.set('n', 's', 's', { noremap = true })

-- make control z do nothing
vim.keymap.set({'n', 'i', 'v'}, '<C-z>', '<Nop>', { noremap = true, silent = true })

-- open undo tree
keymap.set("n", "<leader>uu", ":UndotreeToggle<CR>", {desc = "open undo tree"})
keymap.set("n", "<leader>uf", ":UndotreeFocus<CR>", {desc = "focus undo tree"})

-- AMAZING move keybinds!!!
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- make control d and u stay centered
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- make navigating search terms start centered
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
