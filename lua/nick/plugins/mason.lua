return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                    "rust_analyzer",
                    "gopls",
                    "html",
                    "cssls",
                    "ols",
                },
                automatic_installation = true,
            })
        end,
    },
}

