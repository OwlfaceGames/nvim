return {
        "leoluz/nvim-dap-go",

        {
                "mfussenegger/nvim-dap",
                dependencies = {
                        "suketa/nvim-dap-ruby"
                },
                config = function()
                        require("dap-ruby").setup()
                end
        },

        {
                "julianolf/nvim-dap-lldb",
                dependencies = {
                        "mfussenegger/nvim-dap"
                },
                opts = {
                        codelldb_path = vim.fn.stdpath("data") .. '/mason/bin/codelldb'
                },
        },
}
