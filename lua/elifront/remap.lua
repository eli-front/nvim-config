vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- leader s to write
vim.keymap.set("n", "<leader>sv", "<cmd>w<CR>")

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- make leader s be mapped to nothing
vim.keymap.set("n", "<leader>s", "")


