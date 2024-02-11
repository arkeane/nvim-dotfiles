local Plugin = {'nvim-telescope/telescope.nvim'}

Plugin.event = 'VeryLazy'

Plugin.dependencies = {
    { 'nvim-lua/plenary.nvim' },
}

return Plugin
