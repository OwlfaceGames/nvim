return {
    "nvim-mini/mini.indentscope",
    version = '*',

    config = function()
        local starter = require('mini.indentscope')
        starter.setup()
    end
}
