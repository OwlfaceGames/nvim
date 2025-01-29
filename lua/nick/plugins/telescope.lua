return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {
        "ThePrimeagen/harpoon",
        "nvim-lua/plenary.nvim",
        "joshmedeski/telescope-smart-goto.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                    n = {
                        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                    },
                },
            },
        })
    end,
}
