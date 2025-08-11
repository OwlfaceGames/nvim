return {
        "monkoose/neocodeium",
        event = "VeryLazy",
        config = function()
                local neocodeium = require("neocodeium")
                neocodeium.setup({enabled = false})
                vim.keymap.set("i", "<A-tab>", neocodeium.accept)
                vim.keymap.set("i", "<C-l>", neocodeium.accept_line)
                vim.keymap.set("i", "<C-w>", neocodeium.accept_word)
        end,
}

