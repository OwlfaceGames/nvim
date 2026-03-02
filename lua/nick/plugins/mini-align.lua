return {
    "nvim-mini/mini.align",
    version = '*',

    config = function()
        local align = require('mini.align')
        align.setup()
    end
}
