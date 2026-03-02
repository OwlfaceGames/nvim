return {
    "nvim-mini/mini.splitjoin",
    version = '*',

    config = function()
        local splitjoin = require('mini.splitjoin')
        splitjoin.setup()
    end
}
