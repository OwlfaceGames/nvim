return {
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.config("dartls", {
                settings = { dart = { lineLength = 52 } },
            })
            vim.lsp.enable("dartls")
        end,
    },
}
