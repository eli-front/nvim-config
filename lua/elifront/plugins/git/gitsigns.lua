return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      auto_attach = true,
      current_line_blame = true,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage Hunk" })
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset Hunk" })
        map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame Line" })
        map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
        map("n", "<leader>gd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>gD", function()
          gs.diffthis("~")
        end, { desc = "Diff This (cached)" })
        map("n", "<leader>td", gs.toggle_deleted, { desc = "Toggle Deleted" })

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
      end,
    })
  end,
}
