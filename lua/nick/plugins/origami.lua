return {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    init = function()
        vim.opt.foldlevel = 99
        vim.opt.foldlevelstart = 99
    end,
    opts = {
        hOnlyOpensOneLevel = false,
    },
    config = function(_, opts)
        require("origami").setup(opts)
        vim.keymap.del("n", "h")
    end,
}
