return {
  'tamton-aquib/duck.nvim',
  config = function()
    vim.keymap.set('n', '<leader>dd', function() require("duck").hatch("🐿️") end, {
      desc = "Hatch a chipmunk"
    })
    vim.keymap.set('n', '<leader>dk', function() require("duck").cook() end, {
      desc = "Cook a chipmunk"
    })
    vim.keymap.set('n', '<leader>da', function() require("duck").cook_all() end, {
      desc = "Cook all chipmunks"
    })

    -- hatch custom from user input
    vim.keymap.set('n', '<leader>dc', function()
      local input = vim.fn.input("Enter an emoji for the chipmunk: ")
      if input ~= "" then
        require("duck").hatch(input)
      else
        vim.notify("No emoji entered", vim.log.levels.WARN)
      end
    end, {
      desc = "Hatch a custom chipmunk"
    })
  end
}
