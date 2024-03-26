return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      auto_attach = true,
      on_attach = function()
        local keymap = vim.keymap
        -- Navigation
        keymap.set("n", "]c", function()
          require("gitsigns").next_hunk()
        end, { desc = "Next hunk" })
        keymap.set("n", "[c", function()
          require("gitsigns").prev_hunk()
        end, { desc = "Previous hunk" })

        -- Actions
        keymap.set("n", "<leader>ghs", function()
          require("gitsigns").stage_hunk()
        end, { desc = "Stage hunk" })
        keymap.set("n", "<leader>ghu", function()
          require("gitsigns").undo_stage_hunk()
        end, { desc = "Undo stage hunk" })
        keymap.set("n", "<leader>ghr", function()
          require("gitsigns").reset_hunk()
        end, { desc = "Reset hunk" })
        keymap.set("n", "<leader>ghS", function()
          require("gitsigns").stage_buffer()
        end, { desc = "Stage buffer" })
        keymap.set("n", "<leader>ghR", function()
          require("gitsigns").reset_buffer()
        end, { desc = "Reset buffer" })
        keymap.set("n", "<leader>ghp", function()
          require("gitsigns").preview_hunk()
        end, { desc = "Preview hunk" })
        keymap.set("n", "<leader>ghb", function()
          require("gitsigns").blame_line({ full = true })
        end, { desc = "Blame line" })
      end,
    })
  end,
}
