vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- open dash
keymap.set("n", "<leader>ds", ":Dash<CR>", { desc = "Search Dash.app" })
keymap.set("n", "<leader>dc", ":Dash <C-r><C-w><CR>", { desc = "Search word under cursor in Dash.app" })

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

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to prev tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- telescope keybinds
keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<CR>", { desc = 'Telescope find files' })
keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<CR>", { desc = 'Telescope live grep' })
keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<CR>", { desc = 'Telescope buffers' })
keymap.set('n', '<leader>fh', "<cmd>Telescope help_tags<CR>", { desc = 'Telescope help tags' })

-- no neck pain
keymap.set("n", "<leader>nn", "<cmd>NoNeckPain<CR>", { desc = "Toggle no neck pain" })

-- line numbers
keymap.set('n', '<leader>nln', ':setlocal nonumber norelativenumber <CR>')
keymap.set('n', '<leader>ln', ':setlocal number relativenumber <CR>')

-- enable neocodium
keymap.set('n', '<leader>ai', ':NeoCodeium enable<CR>')
keymap.set('n', '<leader>nai', ':NeoCodeium disable<CR>')

-- oil
keymap.set('n', '<leader>o', ':Oil<CR>')

-- quick list
keymap.set('n', '<leader>qo', ':copen<CR>')
keymap.set('n', '<leader>qn', ':cNext<CR>')
keymap.set('n', '<leader>qp', ':cprevious<CR>')

-- quit terminal mode
keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
