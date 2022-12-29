local M = {
  "akinsho/bufferline.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  event = "BufReadPre",
}

function M.config()
  require("bufferline").setup({
    options = {
      show_close_icon = false,
      show_buffer_close_icons = false,
    },
    highlights = { buffer_selected = { bold = true } },
  })
end

return M
