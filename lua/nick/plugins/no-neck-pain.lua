return {
    "shortcuts/no-neck-pain.nvim",
    config = function()
        require('no-neck-pain').setup({
            width = 88,
            autocmds = {
                enableOnVimEnter = true,
            },
        })
    end,
}
--------------------------------------------------------------------------------
