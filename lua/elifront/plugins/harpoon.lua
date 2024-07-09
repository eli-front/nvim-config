return {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Add File" })
    vim.keymap.set("n", "<leader>hr", mark.rm_file, { desc = "Rm File" })
    vim.keymap.set("n", "<leader>hn", ui.nav_next, { desc = "Nav Next" })
    vim.keymap.set("n", "<leader>hp", ui.nav_prev, { desc = "Nav Prev" })
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
  end
}
