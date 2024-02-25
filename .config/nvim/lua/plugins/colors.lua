local M = {
  {
    "Mofiqul/adwaita.nvim",
    config = function()
      vim.g.adwaita_darker = true
      vim.g.adwaita_disable_cursorline = true
      vim.g.adwaita_transparent = true
    end
  },
  {
    "ramojus/mellifluous.nvim",
    dependencies = { "rktjmp/lush.nvim" },
  },
  "rmehri01/onenord.nvim",
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup {
        style = "darker"
      }
    end
  },
  { "shaunsingh/oxocarbon.nvim" },
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
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require 'nordic'.load()
    end
  },
  "kaiuri/nvim-juliana",
  "arzg/vim-colors-xcode"
}

return M
