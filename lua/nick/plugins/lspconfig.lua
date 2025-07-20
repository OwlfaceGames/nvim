return {
	{
		"b0o/SchemaStore.nvim",
		lazy = true
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").dartls.setup({
				settings = { dart = { lineLength = 52 } },
			})
		end,
	},
}