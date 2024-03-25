local keymap = vim.keymap -- for conciseness

-- lazy
keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy" })

-- set jj to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- set <leader>w to save
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save Buffer" })

-- set <leader>q to quit
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- <leader>th for terminal horizontal
keymap.set("n", "<leader>th", ":rightbelow split | terminal<CR>", { desc = "Horizontal" })

-- control ' to close current window
keymap.set({ "n", "i" }, "<C-'>", ":close<CR>", { desc = "Close Window" })

keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- glslView
keymap.set("n", "<leader>v", ":GlslView<CR>", { desc = "GlslView" })

-- copy / paste to clipboard
keymap.set("v", "<leader>cc", '"+y', { desc = "Copy to clipboard" })
keymap.set("n", "<leader>cp", '"+p', { desc = "Paste from clipboard" })
keymap.set("n", "<leader>cl", '"+yy', { desc = "Copy line to clipboard" })
keymap.set("n", "<leader>cb", ":%y+<CR>", { desc = "Copy buffer to clipboard" })
