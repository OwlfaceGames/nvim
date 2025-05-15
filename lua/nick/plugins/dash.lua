return {
    "mrjones2014/dash.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    build = "make install",
    config = function()
        -- Wrap in pcall to prevent errors if module still isn't available
        local ok, dash = pcall(require, "dash")
        if not ok then
            vim.notify(
                "dash.nvim not properly installed. Try running 'cd ~/.local/share/nvim/lazy/dash.nvim && make install' manually",
                vim.log.levels.WARN)
            return
        end

        -- Configure with default settings
        dash.setup()
    end,
}
