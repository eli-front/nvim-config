return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      columns = {
        "icon",
        "git_status"
      },
      view_options = {
        show_hidden = true,
        is_hidden_file = function(file)
          -- check if in a git repo. if not, return false
          local git_dir = vim.fn.system("git rev-parse --is-inside-work-tree")
          if git_dir ~= "true\n" then
            return false
          end

          -- Check if the file is gitignored
          local gitignore_cmd = string.format("git check-ignore %q", file)
          local output = vim.fn.systemlist(gitignore_cmd)

          -- If output is non-empty, the file is ignored
          return #output > 0
        end,
      },
    })

    vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { silent = true })
  end
}
