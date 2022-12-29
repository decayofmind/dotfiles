local M = {
  {
    "RRethy/nvim-base16",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme base16-" .. vim.env.BASE16_THEME)
    end,
  },
  {
    "marko-cerovac/material.nvim",
    config = function()
      vim.g.material_style = "darker"
    end,
  },
}

return M
