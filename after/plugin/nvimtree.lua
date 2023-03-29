
local map = vim.api.nvim_set_keymap

map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

require('nvim-tree').setup({
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {}
    },
    view = {
        width = 30,
        side = 'left',
        mappings = {
        custom_only = false,
        list = {}
        }
    }
})
