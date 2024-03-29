local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "kyazdani42/nvim-web-devicons", "SmiteshP/nvim-navic" },
}

function M.config()
  local navic = require("nvim-navic")
  require("lualine").setup({
    extensions = {
      "neo-tree",
      "nvim-dap-ui",
      "quickfix",
      "symbols-outline",
      "toggleterm",
      "trouble",
    },
    options = {
      component_separators = { " ", " " },
      section_separators = { " ", " " },
    },
    sections = {
      lualine_a = { {
        "filename",
        path = 1,
        symbols = { modified = "", readonly = "", unnamed = "" },
      } },
      lualine_b = {
        "branch",
        {
          "diagnostics",
          sources = { "nvim_lsp" },
          symbols = { error = " ", warn = " ", info = " ", hint = "" },
        },
      },
      lualine_c = {
        {
          function()
            return navic.get_location()
          end,
          cond = function()
            return navic.is_available()
          end
        },
      }
    },
    inactive_sections = {
      lualine_a = { {
        "filename",
        path = 1,
        symbols = { modified = "", readonly = "", unnamed = "" },
      } },
      lualine_c = {},
    }
  })
end

return M
