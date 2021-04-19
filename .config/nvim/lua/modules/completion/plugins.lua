local completion = {}
local config = require('modules.completion.config')

completion['hrsh7th/nvim-compe'] = {
    event = 'InsertEnter',
    config = config.compe
}

return completion
