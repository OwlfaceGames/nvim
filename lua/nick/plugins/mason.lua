return {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"clangd",
				"pyright",
				"tsserver",
				"rust_analyzer",
				"gopls",
				"html",
				"cssls",
			},
			automatic_installation = true,
		})
	end,
}