local keymap = vim.keymap -- for conciseness


-- set jj to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- set <leader>w to save
keymap.set('n', '<leader>w', ':w<CR>', {desc = "Save Buffer" })

-- set <leader>q to quit
keymap.set('n', '<leader>q', ':q<CR>', {desc = "Quit"})

-- <leader>th for terminal horizontal
keymap.set('n', '<leader>th', ':rightbelow split | terminal<CR>', {desc = "Horizontal"})

