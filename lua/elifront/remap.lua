vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>sv", "<cmd>w<CR>")
vim.keymap.set("n", "<C-s>", function()
    vim.cmd("w")
end)


-- control shift f
vim.keymap.set("n", "<CS-f>", "<cmd>lua require('telescope.builtin').grep_string()<CR>")
