return {
    'numToStr/Comment.nvim',
    lazy = false, -- Prevent it from loading too late
    config = function()
        require('Comment').setup()
    end
}

