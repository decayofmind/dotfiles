local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = { "▏" },
    },
    exclude = {
      buftypes = { "terminal", "nofile" },
      filetypes = { "help", "Trouble", "lspinfo", "markdown" },
    },
  }
}

return M
