return {
  {
    "timtro/glslView-nvim",
    config = function()
      vim.g.glslViewer = "glslViewer"
      -- setu
      local glsl = require("glslView")

      glsl.setup({
        viewer_path = "glslViewer",
        ft = "glsl",
        args = { "-l" },
      })
    end,
  },
}
