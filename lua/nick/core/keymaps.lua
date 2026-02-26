vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- swap p and shift p binds for visual mode for normal paste over functionality
keymap.set('v', 'p', 'P', { noremap = true })
keymap.set('v', 'P', 'p', { noremap = true })

-- Map gd to LSP definition
keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })

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

-- no neck pain
keymap.set("n", "<leader>nn", "<cmd>NoNeckPain<CR>", { desc = "Toggle no neck pain" })

-- line numbers
keymap.set('n', '<leader>nln', ':setlocal nonumber norelativenumber <CR>')
keymap.set('n', '<leader>ln', ':setlocal number relativenumber <CR>')
keymap.set('n', '<leader>lnn', ':setlocal number norelativenumber <CR>')

-- oil
keymap.set('n', '<leader>o', ':Oil<CR>')

-- open exporer
keymap.set('n', '<leader>e', ':Neotree<CR>')

-- neocodeium
keymap.set('n', '<leader>n', ':NeoCodeium toggle<CR>')

-- quick list
keymap.set('n', '<leader>qo', ':copen<CR>')
keymap.set('n', '<leader>qn', ':cNext<CR>')
keymap.set('n', '<leader>qp', ':cprevious<CR>')

-- new floating terminal
keymap.set('n', '<leader>tt', ':ToggleTerm<CR>')
keymap.set('n', '<leader>t', ':TermExec cmd="tsk -q"<CR>') -- run tasker

-- quit terminal mode
keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Key mappings for debugging
keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = "Start/Continue debugging" })
keymap.set('n', '<F1>', function() require('dap').step_over() end, { desc = "Step over" })
keymap.set('n', '<F2>', function() require('dap').step_into() end, { desc = "Step into" })
keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = "Step out" })
keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = "Toggle breakpoint" })
keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = "Open DAP REPL" })
keymap.set('n', '<Leader>du', function() require('dapui').toggle() end, { desc = "Toggle DAP UI" })

-- Resize vim window
keymap.set('n', '<leader>k', ':resize -2<CR>', { silent = true })
keymap.set('n', '<leader>j', ':resize +2<CR>', { silent = true })
keymap.set('n', '<leader>h', ':vertical resize -2<CR>', { silent = true })
keymap.set('n', '<leader>l', ':vertical resize +2<CR>', { silent = true })

-- set color column
keymap.set('n', '<leader>lc', ':set colorcolumn=80<CR>', { silent = true })
keymap.set('n', '<leader>nlc', ':set colorcolumn=<CR>', { silent = true })

-- set winbar
keymap.set('n', '<leader>wb', ':set winbar=%f<CR>', { silent = true })
keymap.set('n', '<leader>nwb', ':set winbar=<CR>', { silent = true })


