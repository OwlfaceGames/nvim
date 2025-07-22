return {
	"hedyhli/outline.nvim",
	config = function()
		vim.keymap.set("n", "<leader>p", "<cmd>Outline<CR>",
			{ desc = "Toggle Outline" })

		require("outline").setup {
			outline_window = {
				position = 'right',
			},
		}
	end,
}
