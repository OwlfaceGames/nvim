return {
    "nvim-mini/mini.surround",
    version = '*',

    config = function()
        local surround = require('mini.surround')
        surround.setup()
    end
}
